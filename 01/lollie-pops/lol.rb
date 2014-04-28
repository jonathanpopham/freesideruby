def pluralize(n)
  n == 1 ? "lolly" : "lollies"
end

def solve(title, num, wait)
  # Determine best possible outcome.
  yes = []
  no = []
  total = []
  (num.length-1).downto(0).each do |i|
    yes[i] = num[i] + total.fetch(i + wait[i], 0)
    no[i] = total.fetch(i + 1, 0)
    total[i] = [yes[i], no[i]].max
  end

  # Determine latest collections giving that outcome.
  counts = []
  limit = 0
  num.each_with_index do |n,i|
    if i >= limit && yes[i] > no[i]
      counts[i] = n
      limit = i + wait[i]
    else
      counts[i] = 0
    end
  end

  # Format output.
  puts "In #{title}, #{total[0]} #{pluralize(total[0])} can be obtained:"
  counts.each_with_index do |c,i|
    puts "On day #{i + 1}, collect #{c} #{pluralize(c)}." if c > 0
  end 
end

title = ''
num = []
wait = []
STDIN.readlines().each do |line|
  if /[[:digit:]]/.match(line[0])
    n,w = line.split(' ').map { |x| x.to_i }
    num << n
    wait << w
  else
    solve(title, num, wait) unless title == ''
    puts unless title == '' || line.strip == '#'
    title = line.strip
    num = []
    wait = []
  end
end
