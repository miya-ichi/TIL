array = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]
count = 0
while count < array.size - 1
    p = 0
    while p < array.size - 1
        if array[p] > array[p + 1]
            number = array[p]
            array[p] = array[p + 1]
            array[p + 1] = number
        end
        p += 1
    end
    count += 1
end
p array