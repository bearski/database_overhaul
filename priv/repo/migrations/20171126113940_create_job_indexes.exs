defmodule DatabaseOverhaul.Repo.Migrations.CreateJobIndexes do
  use Ecto.Migration

  def up do
    execute """
      CREATE INDEX jobs_trigger_id_index
      ON public.jobs USING btree(trigger_id)
    """
  end

  def down do
    execute "DROP INDEX public.jobs_trigger_id_index;"
  end
end
