require './helper'

exp_x =  " GATCGGCAT "
exp_y = "CAATGTGAATC"
exp_cost = "*-++--+-++* (-3)"
x = "GATCGGCAT"
y = "CAATGTGAATC"
Helper.test_genes x, y, exp_x, exp_y, exp_cost, "handout"
