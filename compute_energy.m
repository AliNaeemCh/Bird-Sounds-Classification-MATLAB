function energy=compute_energy(frames)
totalframes=size(frames,1);
for i=1:totalframes
    energy(i,:)=sum(frames(i,:).^2);
end
end