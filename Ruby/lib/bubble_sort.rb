def bubble_sort(array)
    0.upto(array.size - 1) do
        0.upto(array.size - 2) do |m|
            if array[m] > array[m + 1]
                array[m], array[m + 1] = array[m + 1], array[m]
            end
        end
    end

    array
end

a = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]

puts "ソート前"
p a

puts "ソート後"
p bubble_sort(a)