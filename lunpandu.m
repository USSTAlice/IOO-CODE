function choosen=lunpandu(C)
%%Roulette
C=C.^5;
C=C+eps;
C=C+randn(1,size(C,2))./10;
value_sum=sum(C);
cc=C./value_sum;
r=rand(1);
pc=cumsum(cc,2);%���ۼӺ�
tar=find(pc>=r);%����pc�д���r��λ������
choosen=tar(1);%�᷵�ض������r��Ԫ�ص�λ�ã�������ֻȡ��һ��Ԫ��
