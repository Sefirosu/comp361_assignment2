module GeneAligner
  def self.align_genes(x,y)
    result = align x, y
    return retrieve result, x, y
  end

  private

  def self.align(x,y)
    a = [x.length + 1][y.length + 1]
    (1..y.length).each {|j| a[0][j] = (j * -2)}
    (1..x.length).each {|i| a[i][0] = (i * -2)}

    (1..y.length).each do |j|
      (1..x.length).each do |i|
        both = a[i-1][j-1] + ((x[i] == y[j]) ? 1 : -1)
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
      both = a[i-1][j-1] + ((x[i] == y[j]) ? 1 : -1)
      x_ins = a[i-1][j] - 2
      y_ins = a[i][j-1] - 2
      if a[i][j] == both
        sol_one = x[i] << sol_one
        sol_two = y[j] << sol_two
        sol_three = (x[i] == y[j] ? [-1] : [1]).concat sol_three
        i = i - 1
        j = j - 1
      elsif a[i][j] == x_ins
        sol_one = x[i] << sol_one
        [-2].concat sol_three
      else
        sol_two = y[j] << sol_two
        [-2].concat sol_three
      end
    end

    while j > 0 do
      sol_two = [" "] << sol_two
      sol_three = [-2].concat sol_three
      j = j-1
    end
    while i > 0 do
      sol_one = [" "] << sol_one
      sol_three = [-2].concat sol_three
      i = i-1
    end
    return { x => sol_one, y => sol_two, :cost => sol_three }
  end
end