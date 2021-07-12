count = 1
max = ARGV[0].to_i

=begin
# whileを使ったパターン
while count <= max
    if count % 15 == 0
        puts "FizzBuzz!"
    elsif count % 3 == 0
        puts "Fizz!"
    elsif count % 5 == 0
        puts "Buzz!"
    else
        puts count
    end
    count += 1
end
=end

# timesメソッドを使ったパターン
max.times do
    if count % 15 == 0
        puts "FizzBuzz!"
    elsif count % 3 == 0
        puts "Fizz!"
    elsif count % 5 == 0
        puts "Buzz!"
    else
        puts count
    end
    count += 1
end
