function identifyframe(frame)
load('melfilterbanks');
load('birdpictures');
birdaudioin.audio=conditionit(frame);
birdaudioin.windowed=window(frame);
birdaudioin.zcr=computezcr(frame);
birdaudioin.framesdft=[];
birdaudioin.framesdft=dft(birdaudioin.windowed);
birdaudioin.logpowerspect=computelogpowerspect(melfilterbanks,birdaudioin.framesdft);
birdaudioin.mfccs=computemfccs(birdaudioin.logpowerspect);
birdaudioin.spectralcentroid=computespectralcentroid(birdaudioin);
birdaudioin.sro=computesro(birdaudioin.framesdft);
fv=fvforframe(birdaudioin);
birdaudioin.featurevector=normalizefeaturevector(fv);
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