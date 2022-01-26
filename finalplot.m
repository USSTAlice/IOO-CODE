function [c,obj]=finalplot(X)
global nodeset s
solution=struct()
obj=[]
for i =1 :1000
    [~,b,c]=Greedyobj(X);
    obj=[obj,b]
    solution(i).obj=b;
    solution(i).allo=c;
end
[~,w]=min(obj);
adj=zeros(66,66);
for i = 1:10
    allo=solution(w(1)).allo
    for j = 1:size(allo,2)
        adj(X(j),allo(j).allo)=1
    end
end
coord=[]
coord(:,1)=nodeset(:,2)
coord(:,2)=nodeset(:,3)
gplot(adj,coord);
obj=obj(w(1));
c=solution(w(1)).allo;
end