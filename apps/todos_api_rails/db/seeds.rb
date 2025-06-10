puts "Seeding data..."

# Create a few users
users = [
  User.create!(name: "Alice", email: "alice@example.com", password: "password"),
  User.create!(name: "Bob", email: "bob@example.com", password: "password"),
  User.create!(name: "Charlie", email: "charlie@example.com", password: "password")
]

# Create an organization owned by Alice
org = Organization.create!(name: "Alpha Org", owner: users[0])
OrganizationMembership.create!(organization: org, user: users[0], organization_role: "owner")
OrganizationMembership.create!(organization: org, user: users[1], organization_role: "member")

# Create a project under the organization owned by Alice
project = Project.create!(name: "Alpha Project", organization: org, user: users[0])
ProjectMembership.create!(project: project, user: users[0], project_role: "owner")
ProjectMembership.create!(project: project, user: users[1], project_role: "editor")

# Add some todos
Todo.create!([
  { title: "Initial Setup", status: "pending", project: project },
  { title: "Deploy MVP", status: "in_progress", project: project }
])

puts "Seeded #{User.count} users, #{Organization.count} orgs, #{Project.count} projects, #{Todo.count} todos"
