n = 0
STDIN.readlines()[1..-1].each_with_index do |line,i|
  if i % 2 == 0
    ed,n = line.split(' ')
    n = ed == 'D' ? -(n.to_i) : n.to_i
  else
    tmp = line.strip.reverse.split('').map do |c|
      if /[[:alpha:]]/.match(c)
        base = /[[:lower:]]/.match(c) ? 'a'.ord : 'A'.ord
        (((c.ord - base) + n) % 26 + base).chr
      else
        c
      end
    end
    puts tmp.join('')
  end
end

