function identifyvector(file)
load('melfilterbanks');
load('birdpictures');
birdaudioin.inputaudio=file;
birdaudioin.audio=conditionit(birdaudioin.inputaudio);
birdaudioin.frames=frameit(birdaudioin.audio,getframesize,getframestep);
[birdaudioin.windowed,birdaudioin.totalwframes]=selectframes(window(birdaudioin.frames));
birdaudioin.zcr=computezcr(birdaudioin.frames);
birdaudioin.framesdft=[];
for j=1:birdaudioin.totalwframes
    birdaudioin.framesdft(j,:)=dft(birdaudioin.windowed(j,:));
end
birdaudioin.logpowerspect=computelogpowerspect(melfilterbanks,birdaudioin.framesdft);
birdaudioin.mfccs=computemfccs(birdaudioin.logpowerspect);
birdaudioin.sro=computesro(birdaudioin.framesdft);
birdaudioin.spectralcentroid=computespectralcentroid(birdaudioin);
birdaudioin.featurevector=normalizefeaturevector(genfv(birdaudioin));
theta=gettheta;
birdaudioin.featurevector(gettotalfeatures+1,1)=1;
identified=false;
disp(' ')
Pden=0;
for j=1:gettotalbirds
Pden=Pden+exp(transpose(theta(:,j))*birdaudioin.featurevector);
end
Pnum=exp(transpose(theta)*birdaudioin.featurevector);
P=Pnum/Pden;

[val,index]=max(P);
    if val>0.5 && index~=9
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