module GeneAligner
  def self.align_genes(x,y)
    result_one = align x, y
    result_two = align x.reverse, y
    use_one = result_one[x.length][y.length] >= result_two[x.length][y.length]

    return retrieve result_one, x, y if use_one
    return retrieve result_two, x.reverse, y 
  end

  private

  def self.align(x,y)
    a = Array.new(x.length + 1){ Array.new(y.length + 1)}
    (0..y.length).each {|j| a[0][j] = (j * -2)}
    (0..x.length).each {|i| a[i][0] = (i * -2)}

    (1..y.length).each do |j|
      (1..x.length).each do |i|
        both = a[i-1][j-1] + ((x[i-1] == y[j-1]) ? 1 : -1)
        x_ins = a[i-1][j] - 2
        y_ins = a[i][j-1] - 2
        a[i][j] = [both, x_ins, y_ins].max
      end
    end
    return a
  end

  def self.retrieve(a, x, y)
    sol_one = ""
    sol_two = ""
    sol_three = []
    i = x.length
    j = y.length

    while i != 0 && j != 0 do
      both = a[i-1][j-1] + ((x[i-1] == y[j-1]) ? 1 : -1)
      x_ins = a[i-1][j] - 2
      y_ins = a[i][j-1] - 2
      if a[i][j] == both
        sol_one = x[i-1] << sol_one
        sol_two = y[j-1] << sol_two
        sol_three = (x[i-1] == y[j-1] ? [1] : [-1]).concat sol_three
        i = i - 1
        j = j - 1
      elsif a[i][j] == x_ins
        sol_one = x[i-1] << sol_one
        sol_two = " " << sol_two
        sol_three = [-2].concat sol_three
        i = i - 1
      else
        sol_two = y[j-1] << sol_two
        sol_one = " " << sol_one
        sol_three = [-2].concat sol_three
        j = j - 1
      end
    end

    while i > 0 do
      sol_one = x[i-1] << sol_one
      sol_two = " " << sol_two
      sol_three = [-2].concat sol_three
      i = i-1
    end
    while j > 0 do
      sol_two = y[j-1] << sol_two
      sol_one = " " << sol_one
      sol_three = [-2].concat sol_three
      j = j-1
    end

    string_representation = "#{sol_one}\n#{sol_two}\n#{generate_costs(sol_three)}\n"

    return { x => sol_one, y => sol_two, :table => a, :cost => sol_three.inject{|sum,x| sum + x },
      :cost_string => generate_costs(sol_three), :string => string_representation, :x => x, :y => y }
  end

  def self.generate_costs(values)
    cost = ""
    total = 0
    values.each do |val|
      total = total + val
      if val == 1
        cost << "+"
      elsif val == -1
        cost << "-"
      else
        cost << "*"
      end
    end
    return cost + " (#{total})"
  end
end