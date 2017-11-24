defmodule DatabaseOverhaul.Receipt do
  use Ecto.Schema

  schema "triggers" do
    field :name, :string
    field :criteria, :map
    field :inbox_id, Ecto.UUID
    field :type, :string
    field :interval, :integer
    field :deleted, :boolean
    field :job_id, :integer
    field :search_vector, :map
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
end
