function P=giveprobability(filename)
load('melfilterbanks');
load('birdpictures');
birdaudioin.info=audioinfo(filename);
birdaudioin.inputaudio=getamplitudescale*audioread(filename);
birdaudioin.inputaudio=birdaudioin.inputaudio/max(abs(birdaudioin.inputaudio));
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
birdaudioin.sro=computesro(birdaudioin.framesdft);
birdaudioin.spectralcentroid=computespectralcentroid(birdaudioin);
birdaudioin.featurevector=normalizefeaturevector(genfv(birdaudioin));
theta=gettheta;
birdaudioin.featurevector=transpose(birdaudioin.featurevector);
birdaudioin.featurevector(gettotalfeatures+1,:)=1;
identified=false;
disp(' ')

% for j=1:gettotalbirds
%    thetaTx(j)= transpose(theta(:,j))*birdaudioin.featurevector;
% end

Pden=0;
for j=1:gettotalbirds
Pden=Pden+exp(transpose(theta(:,j))*birdaudioin.featurevector);
end
Pnum=exp(transpose(theta)*birdaudioin.featurevector);
P=Pnum/Pden;
end