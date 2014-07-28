# Write code using methods on at least one number, string, symbol, array and hash. Make a gist from the code.

NUM = 18
STR = "Bad Ass Mamma Jamma"
EXAMPLE_ARR = [1, 2, 3]
EXAMPLE_HASH = {a: 1, b: 2, c: 3}

def minor?(age)
  age < NUM
end

def awesome?(input)
  input == STR
end

def longsym?(sym)
  sym.id2name.length > 20
end

def arrValuesSameAsHashValues(arr, hash)
  hash.values == arr
end