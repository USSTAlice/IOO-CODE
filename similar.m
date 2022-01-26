function resemble = similar(individual1,individual2)
k = zeros(1,length(individual1));
for i = 1:length(individual1)
    if find(individual1(i)==individual2)
        k(i)=1;
    end
end
resemble=sum(k)/length(individual1);
end