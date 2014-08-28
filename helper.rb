module Helper

  def self.print_result_table(result)
    results = result[:table]
    x = result[:x]
    y = result[:y]
    print "        "
    y.chars.each do |char|
      print char.rjust(3), " "
    end
    print "\n"
    results.each_with_index do |row, i|
      print "#{x[i-1].rjust(3)}|" if i > 0
      print "   |" if i == 0
      row.each do |num|
        print "#{num.to_s.rjust(3)}|"
      end
      print "\n"
    end
  end

end