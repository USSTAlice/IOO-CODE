function choosen=lunpandu(C)
%%Roulette
C=C.^5;
C=C+eps;
C=C+randn(1,size(C,2))./10;
value_sum=sum(C);
cc=C./value_sum;
r=rand(1);
pc=cumsum(cc,2);%求累加和
tar=find(pc>=r);%返回pc中大于r的位置索引
choosen=tar(1);%会返回多个大于r的元素的位置，但我们只取第一个元素
