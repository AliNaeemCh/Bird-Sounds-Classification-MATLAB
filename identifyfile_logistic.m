function identifyfile(filename)
load('melfilterbanks');
load('birdpictures');
birdaudioin.info=audioinfo(filename);
birdaudioin.inputaudio=audioread(filename);
birdaudioin.audio=conditionit(birdaudioin.inputaudio,birdaudioin.info);
birdaudioin.frames=frameit(birdaudioin.audio,getframesize,getframestep);
[birdaudioin.windowed,birdaudioin.totalwframes]=selectframes(window(birdaudioin.frames));
birdaudioin.zcr=computezcr(birdaudioin.frames);
birdaudioin.framesdft=[];
for j=1:birdaudioin.totalwframes
    birdaudioin.framesdft(j,:)=dft(birdaudioin.windowed(j,:));
end
birdaudioin.logpowerspect=computelogpowerspect(melfilterbanks,birdaudioin.framesdft);
birdaudioin.mfccs=computemfccs(birdaudioin.logpowerspect);
birdaudioin.spectralcentroid=computespectralcentroid(birdaudioin);
birdaudioin.sro=computesro(birdaudioin.framesdft);
birdaudioin.featurevector=normalizefeaturevector(genfv(birdaudioin));
birdaudioin.featurevector=transpose(birdaudioin.featurevector);
weightvector=transpose(getweightvector);
bvector=getbvector;
identified=false;
disp(' ')
for i=1:gettotalbirds
    results(i)=gsigmoid(birdaudioin.featurevector*transpose(weightvector(i,:))+bvector(i));
end
[val,index]=max(results);
    if val>0.5
        disp(['Bird Name: ',num2str(getbirdnames(index))])
        imshow(cell2mat(birdpictures(index)));
        title(getbirdnames(index))
        set(gca,'fontsize',15)
        identified=true;
    end
if identified==false
    disp("Can't Identify the Bird")
end
disp(' ')
end