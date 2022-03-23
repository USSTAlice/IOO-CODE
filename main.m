clear all;
%%sometims drop in a infeasible solution which may lead to a endless loop
%% Initialize an antibody population  in a random way;
tic
load node.mat;
load DIS.mat
d=10*s
global DIS nodeset s
p=10
G=150
p1=20
p2=10
thetamin=0
thetamax=0.9
miumin=2
miumax=10
miu=miumin
eta=0.95
individuals = struct('fitness',zeros(1,p1+p2),'concentration',zeros(1,p1+p2),'erp',zeros(1,p1+p2),'facility',[])
trace=[]
code=[]
average=[]
for i = 1:p1+p2
    temp=randperm(size(nodeset,1))
    temp=temp(1:p)
    individuals.facility(i,:)=temp
end
s=11*s
%%Evaluate each antibody  by using the greed procedure
for i = 1:p1+p2
    while isequal(individuals.fitness(i),0)
        [individuals.facility(i,:),individuals.fitness(i)]=Greedyfit(individuals.facility(i,:));
    end
end
%% sort
gbest=individuals.facility(find(individuals.fitness==max(individuals.fitness)),:);
%%Initialize the parent population ?1 by using the first ?1 antibodies in ?;
% Initialize the memory cells ?2 by using the first ?2 antibodies in ?;
for l = 1:p1+p2
    individuals.concentration(l)=concen(l,p1+p2,individuals);
end
individuals.erp=excellence(individuals,p1+p2,eta); %calculate the expected reproduction probability of each antibody i
P1=bestselect(individuals,p1+p2,p1);
P2=bestselect(individuals,p1+p2,p2);
%%
for i = 1:G
    s=s-1/G*d
    for j =1: p1/2
        [parent1,parent2]=selection(P1);
        r = thetamin + (thetamax-thetamin).*rand();
        gamma=rand();
        if gamma<r
            [child1,child2]=onepointcrossover(parent1,parent2);
        else
            [child1,child2]=twopointcrossover(parent1,parent2);
        end
        if miu<miumax
            miu=miu+1;
        else
            miu=miumin;
        end
        child1=mutation(child1,miu,10);
        child2=mutation(child2,miu,10);
        
        individuals.facility(2*j,:)=child1;
        individuals.facility(2*j+1,:)=child2;
    end
    individuals.facility(p1+1:p1+p2,:)=P2.facility;
    individuals.fitness(p1+1:p1+p2)=P2.fitness;
    box=[];
    for k = 1:p1
        [~,temp]=Greedyfit(individuals.facility(k,:));
        box=[];
        for p = 1:10 % 10 times to get best fit
            while isequal(temp,0)
                [~,temp]=Greedyfit(individuals.facility(k,:));
            end
            box=[box,temp];
            individuals.fitness(k)=mean(box);
        end
    end
    %% sort
    %%Initialize the parent population P1 by using the first p1 antibodies in ?;
    % Initialize the memory cells P2 by using the first P2 antibodies in ?;
    for l = 1:p1+p2
        individuals.concentration(l)=concen(l,p1+p2,individuals);
    end
    individuals.erp=excellence(individuals,p1+p2,0.9); %calculate the expected reproduction probability of each antibody i
    P1=bestselect(individuals,p1+p2,p1);
    P2=bestselect(individuals,p1+p2,p2);
    temp=find(individuals.fitness==max(individuals.fitness));
    gbest=P2.facility(1,:);
    for p = 1:100 %Calculate 40 times to get the best result
        [~,temp,~]=Greedyobj(gbest);
        box=[]
        while isequal(temp,NaN)
            [~,temp,~]=Greedyobj(gbest);
        end
        box=[box,temp];
        b=min(box);
    end
    average=[average,max(P2.fitness)];
    trace=[trace,b];
    code=[code;gbest];
end
%%
 plot(average)
 figure
 trace=fillmissing(trace,'linear')
 plot(trace)
 figure
 gbest=code(find(trace==min(trace)),:)
 gbest=gbest(1,:);
 finalplot(gbest) %plot
 toc