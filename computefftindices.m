function indices=computefftindices(dftpoints)
bits=log2(dftpoints);
for i=0:dftpoints-1
    indices(i+1)=bin2dec(num2str(fliplr(de2bi(i,bits,'left-msb'))));
end
end