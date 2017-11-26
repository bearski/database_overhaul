defmodule DatabaseOverhaul.Repo.Migrations.CreateReceiptIndexes do
  use Ecto.Migration

  def up do
    execute """
      CREATE TEXT SEARCH DICTIONARY english_stem_nostop (
          Template = pg_catalog.simple
      );
    """

    execute """
      CREATE TEXT SEARCH CONFIGURATION public.english_nostop ( COPY = pg_catalog.english );
    """

    execute """
      ALTER TEXT SEARCH CONFIGURATION public.english_nostop
      ALTER MAPPING FOR asciiword, asciihword, hword_asciipart, hword, hword_part, word WITH english_stem_nostop;
    """

    execute """
      CREATE INDEX receipt_search_index
      ON receipts USING GIN(search_vector)
    """

    execute """
      CREATE OR REPLACE FUNCTION receipts_search_trigger()
      RETURNS trigger AS
      $$
      BEGIN
        IF TG_OP = 'INSERT' THEN
          NEW.search_vector = to_tsvector('english_nostop', coalesce(NEW.body::text,''));
        END IF;

        IF TG_OP = 'UPDATE' THEN
          IF NEW.body <> OLD.body THEN
            NEW.search_vector = to_tsvector('english_nostop', coalesce(NEW.body::text,''));
          END IF;
        END IF;

        RETURN NEW;
      END
      $$
      LANGUAGE plpgsql;
    """

    execute """
      CREATE TRIGGER receipts_tsvector_update
      BEFORE INSERT OR UPDATE
      ON receipts
      FOR EACH ROW
      EXECUTE PROCEDURE receipts_search_trigger();
    """

    execute """
      CREATE INDEX receipts_content_idx
      ON public.receipts USING gin(body)
    """

    execute """
      CREATE INDEX receipts_inbox_id_index
      ON public.receipts USING btree(inbox_id)
    """

    execute """
    CREATE INDEX receipts_inserted_at_index
    ON public.receipts USING btree(inserted_at)
    """
  end

  def down do
    execute "DROP TEXT SEARCH CONFIGURATION english_nostop"
    execute "DROP TEXT SEARCH DICTIONARY english_stem_nostop"
    execute "DROP TRIGGER receipts_tsvector_update ON public.receipts;"
    execute "DROP FUNCTION public.receipts_search_trigger();"
    execute "DROP INDEX public.receipt_search_index;"
    execute "DROP INDEX public.receipts_content_idx;"
    execute "DROP INDEX public.receipts_inbox_id_index;"
    execute "DROP INDEX public.receipts_inserted_at_index;"
  end
end
