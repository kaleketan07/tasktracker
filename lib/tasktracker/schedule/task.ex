defmodule Tasktracker.Schedule.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Task


  schema "tasks" do
    field :body, :string
    field :status, :boolean, default: false
    field :timespent, :integer
    field :title, :string
    belongs_to :user, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :body, :status, :timespent, :user_id])
    |> validate_required([:title, :body, :status, :user_id])
    |> validate_time
  end

  defp validate_time(changeset) do
    timespent = get_field(changeset, :timespent)
    IO.inspect is_integer(timespent)
    if timespent do
      IO.inspect timespent
      if (rem timespent, 15) == 0 do
        changeset
      else
        # put_change(changeset, :errors, "Time must be a multiple of 15")
        changeset = add_error(changeset, :timespent, "the time MUST be in intervals of 15 minutes")
        IO.inspect changeset
      end
    else
      changeset
    end
  end
end
