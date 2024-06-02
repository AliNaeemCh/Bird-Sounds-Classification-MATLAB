function mfccs=computemfccs(logpowerspect)
totalframes=size(logpowerspect,1);
for i=1:totalframes
    mfccs(i,:)=computedct(logpowerspect(i,:),getfirstmfcc-1,getlastmfcc-1);
end
delmfccs=computedelmfccs(mfccs);
mfccs=[mfccs delmfccs];
end