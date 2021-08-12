def selection_sort(array)
  0.upto(array.size - 1) do |n|
    min_index = n

    (n + 1).upto(array.size - 1) do |m|
      if array[m] < array[min_index]
        min_index = m
      end
    end

    array[n], array[min_index] = array[min_index], array[n]
  end

  array
end

a = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]

puts "ソート前"
p a

puts "ソート後"
p selection_sort(a)
