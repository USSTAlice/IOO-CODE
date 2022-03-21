function [vector,f,xij]= Greedyobj(X)
%%Calculate objective
global DIS nodeset s
xx=setdiff(randperm(size(nodeset,1)),X);
k=size(nodeset,1)-size(X,2);
usedcap=[];
l=100
xij=struct();
for i = 1:size(X,2)
    usedcap(i) = 0;
    xij(i).allo=[];
end
while k>0
    temp=randi(k);
    i=xx(temp);
    setbss=[];
    for j = 1:size(X,2)
        if usedcap(j) + nodeset(i,4)<=20&& DIS(i,X(j))<s
            setbss=[setbss,X(j)];
        end
    end
    setbss=unique(setbss);
    if ~isempty(setbss)
        [~,index]=min(DIS(i,setbss));
        temp=setbss(index);
        temp=find(X==temp);
        xij(temp).allo=[xij(temp).allo,i];
        usedcap(temp)=usedcap(temp)+nodeset(i,4);
        k=k-1;
        xx(find(xx==i))=[];
    else
        f=NaN;
        temp=randperm(size(nodeset,1));
        vector=temp(1:10);
        return
    end
end
cost=0;
for i = 1:size(X,2)
    cost=cost+l*sum(nodeset(xij(i).allo,4).*(DIS(X(i),xij(i).allo).'*0.175425*0.686*1.48586+0.5*10.8777));
end
obj=0.08*1.08^20/(1.08^20-1)*size(X,2)*1.076*20000000+365*cost;
f=obj;
vector=X;
end
        