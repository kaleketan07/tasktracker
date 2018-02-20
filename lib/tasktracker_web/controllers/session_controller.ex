defmodule TasktrackerWeb.SessionController do
  use TasktrackerWeb, :controller

  def create(conn, %{"email" => email}) do
    # Fetch the user associated with the email
    usr = Tasktracker.Accounts.get_user_by_email(email)
    if usr do
      conn
      |> put_session(:user_id, usr.id)
      |> put_flash(:info, "Welcome, #{usr.name}")
      |> redirect(to: "/agenda")
    else
      conn
      |> put_flash(:error, "Error creating a session!")
      |> redirect(to: page_path(conn, :index))
    end

  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Log out successful..")
    |> redirect(to: page_path(conn, :index))
  end

end
