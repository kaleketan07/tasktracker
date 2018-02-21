# Tasktracker

This is a Task tracking application, where the user can:
- create Account
- Log In/ Log Out of the Accounts
- Create tasks and assign them to themselves or to a user from the list of available Users
- Can keep track of the amount of time they have spent on a given task assigned to them


Major Design Decisions:
- The edit and delete functionality for tasks is only allowed to the users to whom the task is Assigned
- If Alice is assigned a task A then A appears on Alice's agenda (home screen for users).
- Any other user say Bob can view the task in all tasks but it will not be visible on his agenda
- Since Bob is not assigned A he cannot edit or delete it
- For user convenience a list of all available users is provided at the time of task creation.
