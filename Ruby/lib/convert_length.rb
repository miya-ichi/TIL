UNITS = { m: 1.0, in: 39.37, ft: 3.28 }
def convert_length(length, from: :m, to: :m)
    (length / UNITS[from] * UNITS[to]).round(2)
end
