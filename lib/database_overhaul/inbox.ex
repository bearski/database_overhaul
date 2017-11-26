defmodule DatabaseOverhaul.Inbox do
  use Ecto.Schema
  use Mix.Task
  
  @primary_key {:id, Ecto.UUID, [autogenerate: true]}
  @foreign_key_type Ecto.UUID

  schema "inboxes" do
    field :title, :string
    field :plan_id, :integer
    field :stripe_subscription_token, :string
    field :stripe_current_period_end, Ecto.DateTime
    field :next_plan_id, :integer
    field :allow_support, :boolean
    field :description, :string
    timestamps([usec: true])
  end

  # @required_fields ~w(inbox_id)
  # @optional_fields ~w(body notes original headers)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  # def changeset(model, params \\ :empty) do
  #   model
  #   |> cast(params, @required_fields ++ @optional_fields)
  # end
  def last_name do
    "Bearski"
  end
end
