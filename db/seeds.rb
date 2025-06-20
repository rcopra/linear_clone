# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear old data
Comment.delete_all
Ticket.delete_all
Project.delete_all
Team.delete_all
User.delete_all

puts '🌱 Seeding data...'

# Create some users
users = 5.times.map do |i|
  User.create!(
    first_name: "User#{i}",
    last_name: "Test#{i}",
    email: "user#{i}@example.com",
    password: 'password'
  )
end

# Create teams
teams = 2.times.map do |i|
  Team.create!(name: "Team #{i + 1}")
end

# Create projects
projects = teams.map do |team|
  2.times.map do |i|
    Project.create!(name: "Project #{i + 1} for #{team.name}", team: team)
  end
end.flatten

# Create tickets
tickets = 6.times.map do |i|
  Ticket.create!(
    title: "Ticket #{i + 1}",
    description: "Details for ticket #{i + 1}",
    status: Ticket.statuses.keys.sample,
    user: users.sample,
    assignee: users.sample,
    project: projects.sample
  )
end

# Add comments
tickets.each do |ticket|
  2.times do
    Comment.create!(
      body: "This is a comment on #{ticket.title}",
      ticket: ticket,
      user: users.sample
    )
  end
end

puts "✅ Seeded #{User.count} users, #{Team.count} teams, #{Project.count} projects, #{Ticket.count} tickets, and #{Comment.count} comments."
