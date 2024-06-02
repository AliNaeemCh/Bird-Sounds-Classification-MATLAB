function logpowerspect=computelogpowerspect(melfilterbanks,framesdft)
hold=[];
[totalframes,holdlength]=size(framesdft);
totalmelfilterbanks=size(melfilterbanks,1);
for i=1:totalframes
    for j=1:totalmelfilterbanks       
        hold=melfilterbanks(j,:).*framesdft(i,:);   
        hold=hold.^2;
        holdsum=0;
        for k=1:holdlength
            holdsum=holdsum+hold(k);
        end
        holdsum=holdsum/holdlength;
        logpowerspect(i,j)=log10(holdsum);
    end
end
end