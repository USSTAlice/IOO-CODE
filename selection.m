function [code1,code2]=selection(individuals)
%%Select parent
parent1index=lunpandu(individuals.erp);
code1=individuals.facility(parent1index,:);
parent2index=lunpandu(individuals.erp);
code2=individuals.facility(parent2index,:);
end