defmodule Tasktracker.ScheduleTest do
  use Tasktracker.DataCase

  alias Tasktracker.Schedule

  describe "tasks" do
    alias Tasktracker.Schedule.Task

    @valid_attrs %{body: "some body", status: true, timespent: 42}
    @update_attrs %{body: "some updated body", status: false, timespent: 43}
    @invalid_attrs %{body: nil, status: nil, timespent: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Schedule.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Schedule.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Schedule.create_task(@valid_attrs)
      assert task.body == "some body"
      assert task.status == true
      assert task.timespent == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Schedule.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.body == "some updated body"
      assert task.status == false
      assert task.timespent == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_task(task, @invalid_attrs)
      assert task == Schedule.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Schedule.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Schedule.change_task(task)
    end
  end

  describe "tasks" do
    alias Tasktracker.Schedule.Task

    @valid_attrs %{body: "some body", status: true, timespent: 42, title: "some title"}
    @update_attrs %{body: "some updated body", status: false, timespent: 43, title: "some updated title"}
    @invalid_attrs %{body: nil, status: nil, timespent: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Schedule.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Schedule.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Schedule.create_task(@valid_attrs)
      assert task.body == "some body"
      assert task.status == true
      assert task.timespent == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Schedule.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.body == "some updated body"
      assert task.status == false
      assert task.timespent == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_task(task, @invalid_attrs)
      assert task == Schedule.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Schedule.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Schedule.change_task(task)
    end
  end
end
