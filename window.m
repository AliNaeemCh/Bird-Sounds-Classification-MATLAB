function windowed=window(frames)
[r,c]=size(frames);
n=linspace(0,c,c);
N=c;                %Length of the window is equal to the size of frame
hamming = 0.54 - 0.46*cos(2*pi*n/N);
windowed=zeros(r,c);
for i=1:r
    windowed(i,:)=frames(i,:).*hamming(1,:);
end
end
    