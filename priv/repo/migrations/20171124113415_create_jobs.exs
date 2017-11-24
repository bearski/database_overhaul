defmodule DatabaseOverhaul.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string
      add :trigger_id, :int
      add :inbox_id, :uuid
      add :expression, :text
      add :credential_id, :int
      add :autoprocess, :bool
      add :adaptor, :string
      add :adaptor_version, :string
      add :archived, :bool
      add :path_in_external_repo, :string
      add :branch_in_external_repo, :string
      add :events, {:array, :map}, default: []
      add :flow_id, :int
      timestamps()
    end
    # create index(:receipts, [:inbox_id])
  end
end
