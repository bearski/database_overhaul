defmodule DatabaseOverhaul.Repo.Migrations.CreateTriggerIndexes do
  use Ecto.Migration

  def up do
    execute """
      CREATE INDEX trigger_search_index
      ON triggers USING GIN(search_vector)
    """

    execute """
      CREATE OR REPLACE FUNCTION triggers_search_trigger()
      RETURNS trigger AS
      $$
      BEGIN
        IF TG_OP = 'INSERT' THEN
          NEW.search_vector = to_tsvector('english_nostop', coalesce(NEW.body::text,''));
        END IF;

        IF TG_OP = 'UPDATE' THEN
          IF NEW.criteria <> OLD.criteria THEN
            NEW.search_vector = to_tsvector('english_nostop', coalesce(NEW.body::text,''));
          END IF;
        END IF;

        RETURN NEW;
      END
      $$
      LANGUAGE plpgsql;
    """

    execute """
      CREATE TRIGGER triggers_tsvector_update
      BEFORE INSERT OR UPDATE
      ON triggers
      FOR EACH ROW
      EXECUTE PROCEDURE triggers_search_trigger();
    """

    execute """
      CREATE INDEX triggers_content_idx
      ON public.triggers USING gin(criteria)
    """

    execute """
      CREATE INDEX triggers_inbox_id_index
      ON public.triggers USING btree(inbox_id)
    """

    execute """
    CREATE INDEX triggers_inserted_at_index
    ON public.triggers USING btree(inserted_at)
    """
  end

  def down do
    execute "DROP TRIGGER triggers_tsvector_update ON public.triggers;"
    execute "DROP FUNCTION public.triggers_search_trigger();"
    execute "DROP INDEX public.trigger_search_index;"
    execute "DROP INDEX public.triggers_content_idx;"
    execute "DROP INDEX public.triggers_inbox_id_index;"
    execute "DROP INDEX public.triggers_inserted_at_index;"
  end
end
