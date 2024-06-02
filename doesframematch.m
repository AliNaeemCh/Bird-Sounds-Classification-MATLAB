function out=doesframematch(frame,birdnumber)
load('melfilterbanks');
birdaudioin.audio=conditionit(frame);
birdaudioin.windowed=window(frame);
birdaudioin.zcr=computezcr(frame);
birdaudioin.framesdft=[];
birdaudioin.framesdft=dft(birdaudioin.windowed);
birdaudioin.logpowerspect=computelogpowerspect(melfilterbanks,birdaudioin.framesdft);
birdaudioin.mfccs=computemfccs(birdaudioin.logpowerspect);
birdaudioin.spectralcentroid=computespectralcentroid(birdaudioin);
fv=fvforframe(birdaudioin);
birdaudioin.featurevector=normalizefeaturevector(fv);
weightvector=getweightvector;
bvector=getbvector;
identified=false;
    if yesorno(birdaudioin.featurevector*transpose(weightvector(birdnumber,:))+bvector(birdnumber))==1
        out=1;
        identified=true;

end
if identified==false
   out=0;
end
end