function rets=bestselect(individuals,m,n)
% Initialize the memory base, and store the overbest individuals with high fitness and low similarity in the group into the memory base according to ERP
s=3;
rets=struct('fitness',zeros(1,n), 'concentration',zeros(1,n),'erp',zeros(1,n),'facility',[]);
[fitness,index] = sort(individuals.fitness,'descend');
for i=1:s
    rets.fitness(i) = individuals.fitness(index(i));   
    rets.concentration(i) = individuals.concentration(index(i));
    rets.erp(i) = individuals.erp(index(i));
    rets.facility(i,:) = individuals.facility(index(i),:);
end

% Remaining M-S individuals
leftindividuals=struct('fitness',zeros(1,m-s), 'concentration',zeros(1,m-s),'erp',zeros(1,m-s),'facility',[]);
for k=1:m-s
    leftindividuals.fitness(k) = individuals.fitness(index(k+s));   
    leftindividuals.concentration(k) = individuals.concentration(index(k+s));
    leftindividuals.erp(k) = individuals.erp(index(k+s));
    leftindividuals.facility(k,:) = individuals.facility(index(k+s),:);
end

% Sort the remaining antibodies by ERP value
[erp,index]=sort(leftindividuals.erp,'descend');

% Select N-S best individuals according to ERP among the remaining antibody groups
for i=s+1:n
    rets.fitness(i) = leftindividuals.fitness(index(i-s));
    rets.concentration(i) = leftindividuals.concentration(index(i-s));
    rets.erp(i) = leftindividuals.erp(index(i-s));
    rets.facility(i,:) = leftindividuals.facility(index(i-s),:);
end

end