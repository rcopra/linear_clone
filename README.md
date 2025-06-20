# Linear Clone

This application is designed to mimic [Linear](https://linear.app/). Development will use RSpec and focus on TDD throughout the build. More details to come later.

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

Summary of Associations

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