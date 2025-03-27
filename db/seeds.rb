# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

puts "Suppression des anciennes réservations..."
Reservation.destroy_all

puts "Suppression des anciens équipements..."
Equipment.all { |equipment| equipment.photos.purge }
Equipment.destroy_all

puts "Suppression des anciens utilisateurs..."
User.destroy_all

puts "Création d'un utilisateur test..."
user = User.create!(
  first_name: "Cécile",
  last_name: "Demo",
  email: "cecile@example.com",
  password: "password"
)
puts "✅ Utilisateur créé : #{user.email}"

puts "Création des équipements..."
equipments = []
10.times do |i|
  equipment = Equipment.create!(
    name: "Équipement #{i + 1}",
    category: ["Accessoire", "Vélo", "Ski", "Surf"].sample,
    price: rand(10..100),
    user: user
  )

  file = URI.open("https://picsum.photos/600/400?#{URI.encode_www_form_component(equipment.category.downcase)}")
  equipment.photos.attach(io: file, filename: "equipment#{i + 1}.jpg", content_type: "image/jpg")

  equipments << equipment
end
puts "✅ 10 équipements créés !"

puts "Création d'une réservation test..."
Reservation.create!(
  user: user,
  equipment: equipments.sample,
  start_date: Date.today,
  end_date: Date.today + 7
)
puts "✅ Réservation test créée !"

puts "🎉 SEED terminé avec succès !"
