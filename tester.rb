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

  def add_perform_test(x, y, name)
    @tests = @tests << {:type => 2,:x => x, :y => y, :n => name}
  end

  def run_tests
    successes = 0
    failures = 0
    @tests.each_with_index do |test, i|
      res = false
      res = test_genes test[:x], test[:y], test[:e_x], test[:e_y], test[:e_c], test[:n], i+1 if test[:type] == 0
      res = test_general_genes test[:x], test[:y], test[:e_c], test[:n], i+1 if test[:type] == 1
      res = test_performance_genes test[:x], test[:y], test[:n], i+1 if test[:type] == 2
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
    #   span_str = Time.at(span).strftime("%9N")
    success = (result[x] == exp_x) && (result[y] == exp_y) && (result[:cost_string] == exp_cost)
    status = success ? "SUCCESS" : "FAILURE"
    a_step = GeneAligner.align_step
    r_step = GeneAligner.retrieve_step
    GeneAligner.reset_barometers
    print "#{status} TEST#{'%03d' % num}: #{'%30s' % name}, took: #{'%.4f' % (span)}s, n = #{x.length > y.length ? x.length : y.length} a-step: #{a_step} r-step: #{r_step}\n"
    #   print "#{status} TEST#{'%03d' % num}: #{'%30s' % name}, took: #{'%.3f' % (span_str.to_f/1000000)}ms, n = #{x.length > y.length ? x.length : y.length} a-step: #{a_step} r-step: #{r_step}\n"
    print "expected:#{exp_cost}, got:#{result[:cost_string]}\n#{result[:string]}\n" if !success
    success
  end

  def test_general_genes(x, y, exp_cost, name, num)
    start = Time.now
    result = GeneAligner.align_genes x, y
    span = Time.now - start
    #   span_str = Time.at(span).strftime("%9N")
    success = (result[:cost] == exp_cost)
    status = success ? "SUCCESS" : "FAILURE"
    a_step = GeneAligner.align_step
    r_step = GeneAligner.retrieve_step
    GeneAligner.reset_barometers
    print "#{status} TEST#{'%03d' % num}: #{'%30s' % name}, took: #{'%.4f' % (span)}s, n = #{x.length > y.length ? x.length : y.length} a-step: #{a_step} r-step: #{r_step}\n"
    print "expected:#{exp_cost}, got:#{result[:cost]}\n#{result[:string]}\n" if !success
    success
  end

  def test_performance_genes(x,y,name,num)
    start = Time.now
    result = GeneAligner.align_genes x, y
    span = Time.now - start
    a_step = GeneAligner.align_step
    r_step = GeneAligner.retrieve_step
    GeneAligner.reset_barometers
    print "PERFORM TEST#{'%03d' % num}: #{'%30s' % name}, took: #{'%.4f' % (span)}s, n = #{x.length > y.length ? x.length : y.length} a-step: #{a_step} r-step: #{r_step}\n"
    true
  end
end
