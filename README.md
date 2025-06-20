# Linear Clone

This application is designed to mimic [Linear](https://linear.app/). Development will use RSpec and focus on TDD throughout the build. This project is for the purpose of learning and my growth as a developer. More details to come later.

<details>
<summary>🔧 Database Schema for MVP</summary>

```plaintext
┌────────────┐        ┌────────────┐        ┌────────────┐
│   Users    │        │  Projects  │        │   Teams    │
├────────────┤        ├────────────┤        ├────────────┤
│ id         │◄────┐  │ id         │◄──┐    │ id         │
│ first_name │     └──│ name       │   └────│ name       │
│ last_name  │        │ team_id FK │        │            │
│ email      │        └────────────┘        └────────────┘
│ password   │
└────────────┘

        ▲
        │
        │ FK
┌───────┴────────┐
│    Tickets     │
├────────────────┤
│ id             │
│ title          │
│ description    │
│ status         │ (enum: open, in_progress, closed)
│ user_id    FK  │►── belongs_to :user
│ project_id FK  │►── belongs_to :project (optional)
│ assignee_id FK │►── user assigned to work on the ticket
├────────────────┤
│ timestamps     │
└────────────────┘

        ▲
        │
        │
┌───────┴────────┐
│   Comments     │
├────────────────┤
│ id             │
│ body           │
│ user_id    FK  │►── author
│ ticket_id  FK  │►── ticket it belongs to
├────────────────┤
│ timestamps     │
└────────────────┘
```
</details>

## Summary of Associations

User

    has_many :tickets (created)

    has_many :assigned_tickets, class_name: "Ticket", foreign_key: :assignee_id

    has_many :comments

Ticket

    belongs_to :user (creator)

    belongs_to :assignee, class_name: "User", optional

    belongs_to :project (optional)

    has_many :comments

Comment

    belongs_to :user

    belongs_to :ticket

Project (optional but helpful)

    belongs_to :team

    has_many :tickets

Team (optional)

    has_many :projects

    has_many :users (could be through memberships)

## ✅ MVP User Stories

This application mimics core functionality of [Linear](https://linear.app), with a TDD approach to development.

### 👤 Users
- [ ] As a user, I can sign up with a first name, last name, email, and password.
- [ ] As a user, I can log in to the app securely.
- [ ] As a user, I can view a list of all users on the team (for assignment purposes).
- [ ] As a user, I can be assigned to tickets.
- [ ] As a user, I can view tickets assigned to me.

### 📋 Tickets
- [ ] As a user, I can create a ticket with a title and description.
- [ ] As a user, I can assign a ticket to a teammate.
- [ ] As a user, I can view all tickets.
- [ ] As a user, I can view details of a specific ticket.
- [ ] As a user, I can change the status of a ticket (`open`, `in_progress`, `closed`).

### 🧑‍🤝‍🧑 Teams
- [ ] As a user, I belong to a team.
- [ ] As a user, I can view the list of team members.
- [ ] As a user, I can see all projects belonging to my team.

### 📁 Projects
- [ ] As a user, I can view a list of projects.
- [ ] As a user, I can create a project and assign it to a team.
- [ ] As a user, I can associate tickets with projects.

### 💬 Comments
- [ ] As a user, I can add a comment to a ticket.
- [ ] As a user, I can view all comments on a ticket.