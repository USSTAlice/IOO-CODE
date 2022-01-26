function c = removing2(pa1,pa2,ch,p,q1,q2)
for s1 = 1 : q1-1
    for s2 = q1 :q2
        if pa1(s1)==pa2(s2)
            ch(s2)=pa2(s1);
        end
    end
end
for s1 = q2+1:p
    for s2 = q1:q2
        if pa1(s1)==pa2(s2)
            ch(s2)=pa2(s1);
        end
    end
end
c=ch;   
end