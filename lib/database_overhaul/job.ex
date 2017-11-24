defmodule DatabaseOverhaul.Job do
  use Ecto.Schema

  schema "jobs" do
    field :name, :string
    field :trigger_id, :integer
    field :inbox_id, Ecto.UUID
    field :expression, :string
    field :credential_id, :integer
    field :autoprocess, :boolean
    field :adaptor, :string
    field :adaptor_version, :string
    field :archived, :boolean
    field :path_in_external_repo, :string
    field :branch_in_external_repo, :string
    field :events, :map
    field :flow_id, :integer
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
