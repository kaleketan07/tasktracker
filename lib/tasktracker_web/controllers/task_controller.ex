defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Task

  def index(conn, _params) do
    tasks = Schedule.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Schedule.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Schedule.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Tasktracker.Accounts.list_users()
                |> Enum.map(&{"#{&1.name}",&1.id})
        render(conn, "new.html", users: users, changeset: changeset) # changed here from new.html to show.html
    end
  end

  def show(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    users = Tasktracker.Accounts.list_users()
            |> Enum.map(&{"#{&1.name}",&1.id})
    task = Schedule.get_task!(id)
    changeset = Schedule.change_task(task)
    render(conn, "edit.html", task: task, users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schedule.get_task!(id)

    case Schedule.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Tasktracker.Accounts.list_users()
                |> Enum.map(&{"#{&1.name}",&1.id})
        render(conn, "edit.html", task: task, users: users,changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    {:ok, _task} = Schedule.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/agenda")
  end
end
