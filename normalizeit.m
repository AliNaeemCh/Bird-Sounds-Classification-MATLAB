function normdata=normalizeit(datamatrix)
[rows,cols]=size(datamatrix);
for i=1:rows
    maxval(i)=max(datamatrix(i,:));
    minval(i)=min(datamatrix(i,:));
    avg(i)=mean(datamatrix(i,:));
    for j=1:cols
        normdata(i,j)=(datamatrix(i,j)-avg(i))/(maxval(i)-minval(i));
    end
end
save('maxval','maxval')
save('minval','minval')
save('avg','avg')
end