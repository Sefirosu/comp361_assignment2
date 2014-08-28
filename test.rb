require './tester'
tester = Tester.new

exp_x =  " GATCGGCAT "
exp_y = "CAATGTGAATC"
exp_cost = "*-++--+-++* (-3)"
x = "GATCGGCAT"
y = "CAATGTGAATC"
tester.add_specific_test x, y, exp_x, exp_y, exp_cost, "handout example"

exp_x =  " GATCGGCAT "
exp_y = "CAATGTGAATC"
exp_cost = "*-++--+-++* (-3)"
x = "GATCGGCAT"
y = "CAATGTGAATC"
tester.add_specific_test x, y, exp_x, exp_y, exp_cost, "handout"

exp_x = "GC C"
exp_y = "CCGC"
exp_cost = "-+*+ (-1)"
x = "GCC"
y = "CCGC"
tester.add_specific_test x, y, exp_x, exp_y, exp_cost, "personal test"

tester.run_tests
