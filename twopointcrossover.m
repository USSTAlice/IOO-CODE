function [ch1,ch2] = twopointcrossover(pa1,pa2)
%%input two parent
%%output two child
p=length(pa1);
q2=randi([3,p-1]);
q1=randi([2,q2]);
child1=pa1;
child2=pa2;
temp=child1(q1:q2);
child1(q1:q2)=child2(q1:q2);
child2(q1:q2)=temp;
temp1=unique(child1);
if length(temp1)<p
    child1=removing2(pa1,pa2,child1,p,q1,q2);
end
temp2=unique(child2);
if length(temp2)<p
    child2=removing2(pa2,pa1,child2,p,q1,q2);
end
child1=unique(child1);
while length(child1)~=p
    for i = 1:p-length(child1)
        child1=[child1,randi(66)];
    end
    unique(child1)
end
child2=unique(child2)
while length(child2)~=p
    for i = 1:p-length(child2)
        child2=[child2,randi(66)];
    end
    unique(child2)
end
ch1=child1;
ch2=child2;
end