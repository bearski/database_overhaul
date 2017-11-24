defmodule DatabaseOverhaul.Repo.Migrations.CreateInbox do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"

    create table(:inboxes, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")
      add :title, :string
      add :plan_id, :int
      add :stripe_subscription_token, :string
      add :stripe_current_period_end, :datetime
      add :next_plan_id, :int
      add :allow_support, :bool
      add :description, :string
      timestamps()
    end
    # create index(:receipts, [:inbox_id])
  end
end
