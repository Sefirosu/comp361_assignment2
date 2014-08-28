require './gene_aligner'

x = "GCC"
y = "CCGC"

result = GeneAligner.align_genes x, y

print result[x] + "\n"
print result[y] + "\n"
print result[:cost]