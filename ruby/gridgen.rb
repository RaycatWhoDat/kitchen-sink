def draw_row(columns = 1, line_or_break = :line)
  delimiters = line_or_break == :break ? ["+", "-"] : ["|", " "]
  columns.times { print delimiters[0], delimiters[1] * 4 }
  puts delimiters[0]
end

def draw_grid(rows = 4)
  rows.times do
    draw_row(rows, :break)
    rows.times { draw_row(rows) }
  end
  draw_row(rows, :break)
end

draw_grid
