# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

linear_algebra = Book.create(name: 'Linear Algebra and Its Applications')
statistics = Book.create(name: 'Statistics for Engineers')
os = Book.create(name: 'Operating Systems Concepts')
algorithms = Book.create(name: 'Introduction to algorithms')
ai = Book.create(name: 'Artificial Intelligence a Modern Approach')
networks = Book.create(name: 'Compter Networks: A Top Down Approach')
machine_learning = Book.create(name: 'AndrewNG Coursera Introduction to Machine Learning')
cryptography = Book.create(name: 'Applied Cryptography')
advanced_algorithms = Book.create(name: 'Algorithm Design')
computer_graphics = Book.create(name: 'EDX Introduction to Computer Graphics')
deep_learning = Book.create(name: 'Deep Learning')
functional_programming = Book.create(name: 'Functional Programming in Scala')
image_processing = Book.create(name: 'Image Processing')
compiler_design = Book.create(name: 'Compiler Design')
distributed_computing = Book.create(name: 'Distributed Computing')
distributed_algorithms = Book.create(name: 'Distributed Algorithms')

last_id = distributed_algorithms.id

linear_algebra.children << ai
linear_algebra.children << algorithms
linear_algebra.children << computer_graphics
linear_algebra.children << image_processing

statistics.children << machine_learning
statistics.children << cryptography
statistics.children << advanced_algorithms

os.children << networks
os.children << compiler_design
os.children << distributed_computing

ai.children << machine_learning
ai.children << advanced_algorithms

machine_learning.children << deep_learning
machine_learning.children << image_processing

algorithms.children << ai
algorithms.children << computer_graphics
algorithms.children << advanced_algorithms
algorithms.children << cryptography
algorithms.children << compiler_design
algorithms.children << functional_programming

advanced_algorithms.children << distributed_algorithms

distributed_computing.children << distributed_algorithms


1000.times do |i|
  book = Book.new
  book.name = Faker::Book.title
  book.description = Faker::OnePiece.quote
  (Random.rand(20) + 1).times do |i|
    book.chapters << Chapter.create(name: Faker::OnePiece.character,
                                    number_of_pages: Random.rand(50) + 1)
  end
  puts book.errors.full_messages.join(', ') unless book.save
  puts "Inserted book #{i + 1}"
end

puts "Connecting #{Book.where('id > ?', last_id).count} books after #{last_id}"

Book.where('id > ?', last_id).find_each do |book|
  20.times do
    rand_book = Book.find(Random.rand(Book.count - last_id) + last_id + 1)
    begin
      book.book_children.build child_id: rand_book.id
      puts "Added #{book.id} -> #{rand_book.id} relation" if book.save
      rescue Exception => e
      # puts e.message
    end
  end
end