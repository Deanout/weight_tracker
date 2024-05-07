# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(email: "dean@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

def create_weight_entries(user, start_weight:, end_weight:, start_date:, end_date:)
  daily_weight_loss = (start_weight - end_weight).to_f / (end_date - start_date).to_i
  current_weight = start_weight

  (start_date..end_date).each do |date|
    puts "Creating weight entry for #{date}..."
    fluctuation = rand(-2.0..2.0) # Random daily fluctuation
    current_weight -= daily_weight_loss + fluctuation
    current_weight = [current_weight, end_weight].max

    user.weights.create(date: date, value: current_weight, unit: 'lbs')
  end
end


create_weight_entries(user,
  start_weight: 195.0,
  end_weight: 175.0,
  start_date: 2.years.ago.to_date,
  end_date: Date.today)
