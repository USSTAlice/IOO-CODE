function c = mutation(ch,miu,p)
%%input child; parameter miu ; length of code 
%%output a new code
global DIS nodeset s
n=size(nodeset,1);
for t = 1:miu
    unopen=setdiff(randperm(size(nodeset,1)),ch);
    q=randi([1,p]);
    q2=randi([1,n-p]);
    temp=ch(q);
    ch(q)=unopen(q2);
    unopen(q2)=temp;
    child1=unique(ch);
    while length(child1)~=10
        for i = 1:10-length(child1)
            child1=[child1,randi(66)];
        end
        child1=unique(child1);
    end
    if t==1
        [best,fitbest]=Greedyfit(child1);
    else
        [tempc,tempf]=Greedyfit(child1);
        if fitbest<tempf
            best=tempc;
        end
    end
end
c=best;
end