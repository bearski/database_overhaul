defmodule DatabaseOverhaul.ReceiptsMV do
  use Ecto.Schema

  @primary_key false

  schema "receipts_body_aggregate" do
    field :inbox_id, Ecto.UUID
    field :body_aggregate, :string
    field :body_aggregate_tsv, :map
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
  def name do
    "ReceiptsMV"
  end
end
