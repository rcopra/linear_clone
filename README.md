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

