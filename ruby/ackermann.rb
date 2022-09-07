def ack(m, n)
  return n + 1 if m == 0
  return ack(m - 1, 1) if m > 0 && n == 0
  return ack(m - 1, ack(m, n - 1))
end

puts ack(ARGV[0].to_i, ARGV[1].to_i) if ARGV.length > 1
