function spectralcentroid=computespectralcentroid(birdaudio)
[totalframes,totaldftpoints]=size(birdaudio.framesdft);

for i=1:totalframes
    num=0;
    den=sum(birdaudio.framesdft(i,:));
    for j=1:totaldftpoints    
        num=num+(j-1)*birdaudio.framesdft(i,j);
    end
    
    spectralcentroid(i)=num*getresolution/den;
end
end