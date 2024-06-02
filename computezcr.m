function zcr=computezcr(frames)
framestopick=pickframes(frames);
totalframes=length(framestopick);
zcr=zeros(1,totalframes);
for i=1:totalframes
    for j=1:getframesize-1
        zcr(1,i)=zcr(1,i)+abs(sign(frames(framestopick(i),j))-sign(frames(framestopick(i),j+1)))/2;
    end
end
end