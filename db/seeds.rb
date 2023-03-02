puts "🌱 Seeding spices..."

# Seed your database here

# create hackathon instance
h1 = Hackathon.create(
    image_url: "",
    topic: "topic",
    description: "desc",
    location: "Kanairo",
    datetime: "02/03/2022 12:00:00"
)

u1 = User.create(
    fullname: "Nondi Non",
    email: "non.di@hi2.in",
    phonenumber: "+25471879264",
    language: "ruby",
    roles: "dev"
)

e1 = Event.create(
    user_id: u1.id,
    hackathon_id: h1.id
)

puts "✅ Done seeding!"
