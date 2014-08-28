require './gene_aligner'
class Tester
  @tests

  def initialize
    @tests = []
  end

  def add_specific_test(x, y, exp_x, exp_y, exp_cost, name)
    @tests = @tests << {:type => 0,:x => x, :y => y, :e_x => exp_x, :e_y => exp_y, :e_c => exp_cost, :n => name}
  end

  def add_general_test(x, y, exp_cost, name)
    @tests = @tests << {:type => 1, :x => x, :y => y, :e_c => exp_cost, :n => name}
  end

  def run_tests
    successes = 0
    failures = 0
    @tests.each_with_index do |test, i|
      res = false
      res = test_genes test[:x], test[:y], test[:e_x], test[:e_y], test[:e_c], test[:n], i+1 if test[:type] == 0
      res = test_general_genes test[:x], test[:y], test[:e_c], test[:n], i+1 if test[:type] == 1
      successes = successes + 1 if res
      failures = failures + 1 if not res
    end
    print "FINISHED TESTS - SUCCESSES:#{successes}, FAILURES:#{failures}\n"
  end

  private

  def test_genes(x, y, exp_x, exp_y, exp_cost, name, num)
    start = Time.now
    result = GeneAligner.align_genes x, y
    span = Time.now - start
    span_str = Time.at(span).strftime("%9N")
    success = (result[x] == exp_x) && (result[y] == exp_y) && (result[:cost_string] == exp_cost)
    status = success ? "SUCCESS" : "FAILURE"
    print "#{status} TEST#{'%03d' % num}: \'#{name}\', took: #{'%.3f' % (span_str.to_f/1000000)}ms\n"
    success
  end

  def test_general_genes(x, y, exp_cost, name, num)
    start = Time.now
    result = GeneAligner.align_genes x, y
    span = Time.now - start
    span_str = Time.at(span).strftime("%9N")
    success = (result[:cost] == exp_cost)
    status = success ? "SUCCESS" : "FAILURE"
    print "#{status} TEST#{'%03d' % num}: \'#{name}\', took: #{'%.3f' % (span_str.to_f/1000000)}ms\n"
    success
  end
end