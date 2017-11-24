defmodule DatabaseOverhaul.Receipt do
  use Ecto.Schema

  schema "receipts" do
    field :inbox_id, Ecto.UUID
    field :notes, :string
    field :headers, :map
    field :body, :map
    field :original, :map
    field :search_vector, :map
    timestamps([usec: true])
  end

  # @required_fields ~w(inbox_id)
  @optional_fields ~w(body notes original headers)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  # def changeset(model, params \\ :empty) do
  #   model
  #   |> cast(params, @required_fields ++ @optional_fields)
  # end
end
