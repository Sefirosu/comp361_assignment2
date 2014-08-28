module GeneAligner
  def self.align_genes(x,y)
    a = [x.length + 1][y.length + 1]
    (1..y.length).each {|j| a[0][j] = (j * -2)}
    (1..x.length).each {|i| a[i][0] = (i * -2)}

    (1..y.length).each do |j|
      (1..x.length).each do |i|
        both = a[i-1][j-1] + ((x[i-1].eql? y[j-1]) ? 1 : -1)
        x_ins = a[i-1][j] - 2
        y_ins = a[i][j-1] - 2
        a[i][j] = [both, x_ins, y_ins].max
      end
    end
  end
end