require './gene_aligner'
require './helper'

# x = "GCC"
# y = "CCGC"
x = "CCTTTTTTTT"
y = "TTTTTTTTGG"

result = GeneAligner.align_genes x, y

print result[:string]
# Helper.print_result_table result # Uncomment this to print my table results

 print "\n"

 x = "GATCGGCAT"
 y = "CAATGTGAATC"

 result = GeneAligner.align_genes x, y

 print result[:string]

# x = "GATTACATACA"
# y = "ACATACATTAG"
# result = GeneAligner.align_genes x, y

# print result[:string]
# Helper.print_result_table result # Uncomment this to print my table results
