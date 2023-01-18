def extract_diamonds_and_sands(expression)
  expression.delete!('.')

  diamonds_count = 0
  diamonds_count += 1 while expression.sub!(/<>/, '')
  diamonds_count
end

puts extract_diamonds_and_sands('<<.<<..>><>><.>.>.<<.>.<.>>>><>><>>')
