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
exp_y = "TCGC"
exp_cost = "-+*+ (-1)"
x = "GCC"
y = "TCGC"
tester.add_specific_test x, y, exp_x, exp_y, exp_cost, "personal test"

x = "GCGCGCGCGC"
y = "ATATATATTATATT"
exp_cost = -18
tester.add_general_test x, y, exp_cost, "completely different genes"

x = "GCGCGCGCGC"
y = "GCGCGCGCGC"
exp_cost = 10
tester.add_general_test x, y, exp_cost, "completely same genes"

x = "GATTACATACA"
y = "ACATACATTAG"
exp_cost = 11
tester.add_general_test x, y, exp_cost, "completely same reversed genes"

tester.run_tests
