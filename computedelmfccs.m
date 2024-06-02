function delmfccs=computedelmfccs(mfccs)
[totalframes,totalmfccs]=size(mfccs);
for i=1:totalframes
    for j=1:totalmfccs-1
        delmfccs(i,j)=mfccs(i,j+1)-mfccs(i,j);
    end
end
end