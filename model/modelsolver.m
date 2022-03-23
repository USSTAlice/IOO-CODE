clear;clc;close all;
load node.mat
p=10
l=100
load DIS.mat
tic
dis=DIS*0.175425*0.686*1.48586+0.5*10.8777
d(1:size(nodeset,1),1)=nodeset(1:size(nodeset,1),4)
for i = 1:size(nodeset,1)
    d(:,i)=d(:,1);
end
n=size(d,1)
for i = 1:n
    dis(i,i)=0;
end
%di=[d1,d1,d1
%    d2,d2,d2
%    d3,d3,d3]
%% 
x=binvar(n,n,'full');
y=binvar(1,n,'full');
z=sum(sum(l*d.*dis.*x))*365+0.08*1.08^20/(1.08^20-1)*p*1.076*20000000;
%%
C=[];
for i = 1:n
    s=sum(x(i,:));
    C=[C,s==1];
end
s=sum(y);
C=[C,s==p];
for j= 1:n
    s=sum(d(:,j).*x(:,j))-20*y(j);
    C=[C,s<=0]
end
for i =1:n
    for j = 1:n
        s=d(i,j)*x(i,j)-29.5
        C=[C,s<=0]
    end
end
% 参数设置
ops = sdpsettings('solver','cplex','verbose',3);
% 求解
result  = optimize(C,z,ops);
if result.problem== 0
    value(x)
    value(z)
else
    disp('求解过程中出错');
end
X=double(x);
coord=[];
coord(:,1)=nodeset(:,2);
coord(:,2)=nodeset(:,3);
gplot(X,coord);
toc