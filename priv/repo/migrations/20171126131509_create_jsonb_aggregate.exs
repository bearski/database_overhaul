defmodule DatabaseOverhaul.Repo.Migrations.CreateJsonbAggregate do
  use Ecto.Migration

  def up do
    execute """
      CREATE AGGREGATE jsonb_object_agg(jsonb) (
      SFUNC = 'jsonb_concat',
      STYPE = jsonb,
      INITCOND = '{}'
      );
    """
  end

  def down do
    execute "DROP AGGREGATE jsonb_object_agg(jsonb);"
  end
end
