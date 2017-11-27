defmodule DatabaseOverhaul.Repo.Migrations.CreateReceiptsMaterialisedView do
  use Ecto.Migration

  def up do
    execute """
      CREATE MATERIALIZED VIEW IF NOT EXISTS receipts_body_aggregate
      as
      select
      	inbox_id,
        body_aggregate,
        to_tsvector('english_nostop', coalesce(body_aggregate::text,'')) body_aggregate_tsv
      from (
        select
          inbox_id,
          jsonb_object_agg(body) body_aggregate
        from receipts
        group by inbox_id
      ) as r0;
    """

    execute """
      CREATE INDEX IF NOT EXISTS receipts_body_aggregate_idx
      ON receipts_body_aggregate
      USING GIN(body_aggregate_tsv);
    """
  end

  def down do
    execute "DROP INDEX IF EXISTS receipts_body_aggregate_idx;"
    execute "DROP MATERIALIZED VIEW IF EXISTS receipts_body_aggregate;"
  end
end
