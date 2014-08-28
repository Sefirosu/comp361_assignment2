require './gene_aligner'

x = "GCC"
y = "CCGC"

result = GeneAligner.align_genes x, y

print result[:string]

print "\n"

x = "GATCGGCAT"
y = "CAATGTGAATC"

result = GeneAligner.align_genes x, y

print result[:string]