load DiagPCG_50_k.csv
load DiagPCG_50_error.csv
plot(list_k, log10(list_error))
print -dpng 'DiagPCG_50.png'