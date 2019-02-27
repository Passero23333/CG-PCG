load CG_5000_k.csv
load CG_5000_error.csv
plot(list_k, log10(list_error))
print -dpng 'CG_5000.png'