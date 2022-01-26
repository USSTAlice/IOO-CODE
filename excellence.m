function exc =excellence(individuals,M,ps)
%%Calculate ERP value
fit=individuals.fitness;
sumfit=sum(fit);
con=individuals.concentration
sumcon=sum(1./con);
for i =1:M
    exc(i) = fit(i)/sumfit*ps+(1/con(i))/sumcon*(1-ps);
end
end