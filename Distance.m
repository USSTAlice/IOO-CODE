function D = Distance(collection_node)
%a=coordinate
%D=distance
row=size(collection_node,1);
D=zeros(row,row);
for i = 1:row
    for j =i+1:row
        D(i,j)=distance(collection_node(i,2),collection_node(i,3),collection_node(j,2),collection_node(j,3))/180*pi*6370;
        D(j,i)=D(i,j);
    end
end
for z=1:row
    D(z,z)=9999;
end