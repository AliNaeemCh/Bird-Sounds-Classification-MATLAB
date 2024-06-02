function normdata=normalizefeaturevector(fv)
l=length(fv);
load('minval')
load('maxval')
load('avg')
for j=1:l
    normdata(j,1)=(fv(j)-avg(j))/(maxval(j)-minval(j));
end
end