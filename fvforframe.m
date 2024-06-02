function featurevector=fvforframe(birdaudio)
totalfiles=size(birdaudio,2);
totalmfccs=(gettotalmelfilterbanks-1) + ((gettotalmelfilterbanks-1)-1); %This includes MFCCs and Delta MFCCs excluding MFCC 1 Value
totalfeaturevals=totalmfccs + 2;    
featurevector=zeros(totalfiles,totalfeaturevals);   
for i=1:totalfiles
    for j=1:totalfeaturevals
        if j<=totalmfccs
            featurevector(i,j)=birdaudio(i).mfccs(j);
        elseif j==totalmfccs+1
            featurevector(i,j)=birdaudio(i).zcr;
        elseif j==totalmfccs+2
            featurevector(i,j)=birdaudio(i).spectralcentroid;
        end
    end
end
end