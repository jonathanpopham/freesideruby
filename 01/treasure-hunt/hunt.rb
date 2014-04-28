grid = STDIN.readlines()[1..-1].map { |line| line.strip.split('') }
gold = 0
height,width = grid.length,grid[0].length
i = grid.flatten.index('P')
queue = [[i / width, i % width]] # add coordinates of P to queue
while !queue.empty?
  r,c = queue.pop
  gold = gold + 1 if grid[r][c] == 'G'
  grid[r][c] = '*'  # mark visited
  neighbors = [[r-1,c], [r,c-1], [r,c+1], [r+1,c]].select do |rr,cc|
      rr.between?(0, height) && cc.between?(0, width) &&
      'G.T'.include?(grid[rr][cc]) # we only care about these neighbors
  end
  next_to_trap = (neighbors.map {|rr,cc| grid[rr][cc]}).include? 'T'
  queue.concat neighbors unless next_to_trap
end
puts gold
