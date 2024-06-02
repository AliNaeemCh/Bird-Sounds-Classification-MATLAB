function frames=frameit(audio,framesize,framestep)
L=length(audio);
R=rem(L-framesize,framestep);
%zero padding if audio length is not proper
if(R~=0)
    zerospadded=(ceil((L-framesize)/framestep))*framestep+framesize-L;
    for i=1:zerospadded
        audio(L+i)=0.0000000001;
    end
    L=length(audio);
end
totalframes=(L-framesize)/framestep+1;
frames=zeros(totalframes,framesize);
for i=1:totalframes
    frames(i,:)=audio((i-1)*framestep+1:framesize+(i-1)*framestep);
end
end