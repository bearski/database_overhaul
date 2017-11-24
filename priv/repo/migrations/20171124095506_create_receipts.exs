defmodule DatabaseOverhaul.Repo.Migrations.CreateReceipts do
  use Ecto.Migration

  def change do
    create table(:receipts) do
      add :inbox_id, :uuid
      add :notes, :text
      add :headers, :jsonb
      add :body, :jsonb
      add :original, :jsonb
      add :search_vector, :tsvector
      timestamps()
    end
    # create index(:receipts, [:inbox_id])
  end
end
