function [c1,c2] = onepointcrossover(pa1,pa2)
%%input two parent
%%output two child
p=length(pa1);
q=randi([2,p-1]);
child1=pa1;
child2=pa2;
temp=child1(q:p);
child1(q:p)=child2(q:p);
child2(q:p)=temp;
temp1=unique(child1);
if length(temp1)<p
    child1=removing(pa1,pa2,child1,p,q);
end
temp2=unique(child2);
if length(temp2)<p
    child2=removing(pa2,pa1,child2,p,q);
end
child1=unique(child1);
while length(child1)~=p
    for i = 1:p-length(child1)
        child1=[child1,randi(66)];
    end
    unique(child1)
end
child2=unique(child2);
while length(child2)~=p
    for i = 1:p-length(child2)
        child2=[child2,randi(66)];
    end
    unique(child2)
end
    
c1=child1;

c2=child2;
end
    