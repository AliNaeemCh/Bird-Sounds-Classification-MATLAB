function sro=computesro(framesdft)
[totalframes,dftvals]=size(framesdft);
threshold=0.8;
sro=zeros(1,totalframes);

for i=1:totalframes
    cumsum=zeros(1,dftvals);
    cumsum(1)=framesdft(i,1);
    for j=2:dftvals
        cumsum(j)=cumsum(j-1)+framesdft(i,j);
    end
    thresholdmag=threshold*cumsum(end);
    for j=1:dftvals
        if cumsum(j)>thresholdmag
            sro(i)=(j-1)*getresolution;
            break;
        end
    end
end
end