defmodule DatabaseOverhaul.Repo.Migrations.CreateTriggers do
  use Ecto.Migration

  def change do
    create table(:triggers) do
      add :name, :string
      add :criteria, :jsonb
      add :inbox_id, :uuid
      add :type, :text
      add :interval, :int
      add :deleted, :bool
      add :job_id, :int
      add :search_vector, :tsvector
      timestamps
    end
    # create index(:receipts, [:inbox_id])
  end
end
