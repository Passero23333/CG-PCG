load CholeskyPCG_5000_k.csv
load CholeskyPCG_5000_error.csv
plot(list_k, log10(list_error))
print -dpng 'CholeskyPCG_5000.png'