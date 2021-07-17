class String
    def shuffle
        chars.shuffle.join
    end
end

s = "こんにちは"
puts s.shuffle
puts s.shuffle