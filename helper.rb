require './gene_aligner'
module Helper

  @test_num = 1

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

  def self.test_genes(x, y, exp_x, exp_y, exp_cost, name)
    start = Time.now
    result = GeneAligner.align_genes x, y
    span = Time.now - start
    span_str = Time.at(span).strftime("%3N")
    success = (result[x] == exp_x) && (result[y] == exp_y) && (result[:cost] == exp_cost)
    status = success ? "SUCCESS" : "FAILURE"
    print "#{status} TEST#{'%03d' % @test_num}: \'#{name}\', took: #{'%.3f' % span_str}ms\n"
    # if result[:string] != expected
    #   print "got:\n" + result[:string]
    #   print "expected:\n#{expected}\n"
    # end
    @test_num = @test_num + 1
  end
end