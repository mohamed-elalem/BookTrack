# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |i|
  book = Book.new
  book.name = Faker::Book.title
  book.description = Faker::OnePiece.quote
  (Random.rand(20) + 1).times do |i|
    book.chapters << Chapter.create(name: Faker::OnePiece.character,
                                    number_of_pages: Random.rand(50) + 1)
  end
  book.save
  puts "Inserted book #{i}"
end