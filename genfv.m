function featurevector=genfv(birdaudio)
totalfiles=size(birdaudio,2);
featurevector=zeros(gettotalfeatures,totalfiles);   
allmfccs=gettotalmfccs+gettotaldelmfccs;
for i=1:totalfiles
    for j=1:gettotalfeatures
        if j<=allmfccs
            featurevector(j,i)=mean(birdaudio(i).mfccs(:,j));
        elseif j==allmfccs+1
            featurevector(j,i)=mean(birdaudio(i).zcr(1,:));
        elseif j==allmfccs+2
            featurevector(j,i)=mean(birdaudio(i).spectralcentroid(1,:));
        elseif j==allmfccs+3
            featurevector(j,i)=mean(birdaudio(i).sro(1,:));
        end
    end
end
end