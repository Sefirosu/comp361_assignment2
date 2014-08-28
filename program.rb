require './gene_aligner'

x = "GCC"
y = "CCGC"

result = GeneAligner.align_genes x, y

print result[x]
print result[y]
print result[:cost]