# 与えられた数字が素数か判定するメソッド
def prime_number?(number)
    n = 2
    while number % n != 0
        # puts n
        n += 1
    end
    n == number ? true : false
end

# 与えられた数字までの間にある素数を配列に詰め込むメソッド
def list_prime_number(number)
    prime_numbers = []
    2.upto(number) do |n|
        if prime_number?(n)
            prime_numbers << n
        end
    end
    prime_numbers
end

a = list_prime_number(ARGV[0].to_i)
puts "入力した数字:#{ARGV[0]}"
p a
puts "素数の数:#{a.size}個"