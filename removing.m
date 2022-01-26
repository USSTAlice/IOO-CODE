function c = removing(pa1,pa2,ch,p,q)
for s1 = 1 : q-1
    for s2 = q :p 
        if pa1(s1)==pa2(s2)
            ch(s2) = pa2(s1);
        end
    end
end
c = ch;
end