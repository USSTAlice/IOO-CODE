clear;clc;close all;
load DIS.mat
load node.mat
tic
dis=DIS*0.175425*0.686*1.48586+0.5*10.8777
for i = 1:66
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
z=sum(sum(d.*dis.*x))*36500+0.08*1.08^20/(1.08^20-1)*10*1.076*20000000;
%%
C=[];
for i = 1:n
    s=sum(x(i,:));
    C=[C,s==1];
end
s=sum(y);
C=[C,s==10];
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
% ��������
ops = sdpsettings('solver','cplex','verbose',3);
% ���
result  = optimize(C,z,ops);
if result.problem== 0
    value(x)
    value(z)
else
    disp('�������г���');
end
X=double(x);
coord=[];
coord(:,1)=nodeset(:,2);
coord(:,2)=nodeset(:,3);
gplot(X,coord);
toc