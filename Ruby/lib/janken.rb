def input_round
    puts "何本勝負？(press 1 or 3 or 5)"
    round = gets.to_i
    if round == 1 || round == 3 || round == 5
        round
    else
        puts "1 or 3 or 5を入力してください"
        input_round
    end
end

def input_hand
    my_hand = gets.chomp
    if my_hand == "g" || my_hand == "c" || my_hand == "p"
        my_hand
    else
        puts "入力しなおしてください(press g or c or p)"
        input_hand
    end
end

def check_win(my_hand, cpu_hand)
    case my_hand + cpu_hand
    when "gc", "cp", "pg"
        "win"
    when "cg", "pc", "gp"
        "lose"
    else
        "draw"
    end
end

def janken(draw = false)
    gcp = {g: "グー", c: "チョキ", p: "パー"}
    puts draw ? "あいこで…(press g or c or p)" : "じゃんけん…(press g or c or p)"
    my_hand = input_hand
    cpu_hand = ["g", "c", "p"].sample
    puts "CPU…#{gcp[cpu_hand.to_sym]}"
    puts "あなた…#{gcp[my_hand.to_sym]}"

    case check_win(my_hand, cpu_hand)
    when "win"
        puts "勝ち！"
        [1, 0]
    when "lose"
        puts "負け！"
        [0, 1]
    when "draw"
        janken(true)
    end
end

round = input_round
my_point = 0
cpu_point = 0

puts "#{round}本勝負を選びました"
#じゃんけん勝負。入力した勝負本数回行う
round.times do |n|
    puts "#{n + 1}本目"
    point = janken
    my_point += point[0]
    cpu_point += point[1]
    puts "#{my_point}勝#{cpu_point}敗"
end

#結果を出力
puts "結果"
puts "#{my_point}勝#{cpu_point}敗であなたの#{my_point > cpu_point ? "勝ち" : "負け"}"
