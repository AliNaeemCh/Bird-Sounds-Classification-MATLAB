function [selectedframes,totalframes]=selectframes(frames)
ind=pickframes(frames);
totalframes=length(ind);
for i=1:totalframes
    selectedframes(i,:)=frames(ind(i),:);
end
end