function density = concen(i,M,individuals)
density=0
for j = 1:M
    xsd = similar(individuals.facility(i,:),individuals.facility(j,:));
    if xsd>0.5
        density = density+1;
    end
end
density = density/M;
end