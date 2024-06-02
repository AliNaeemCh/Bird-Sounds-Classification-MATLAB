function conditionedaudio=cleanit(originalaudio,info,Fs)
 if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
 end
%Resampling%
if(info.SampleRate~=Fs)
    originalaudio=resample(originalaudio,Fs,info.SampleRate);
end
%Silencing the Noise%
windowsize=300;
stepsize=30;
L=length(originalaudio);
threshold=0.01;
R=rem(L,windowsize);
if R~=0
    zerospadded=windowsize-R;
    for i=1:zerospadded
        originalaudio(L+i)=0;
    end
    L=L+zerospadded;
end
conditionedaudio=[];
absaudio=abs(originalaudio);
totaliterations=((L-windowsize)/stepsize)+1;
index=1;
for i=1:totaliterations
    sum=0;
    for j=1:windowsize
        sum=sum+absaudio((i-1)*stepsize+j);
    end  
        if sum/windowsize>=threshold
            for j=1:stepsize
                conditionedaudio(index)=originalaudio((i-1)*stepsize+j);
                index=index+1;
            end
        end
end
sum=0;
conditionedlength=length(conditionedaudio);
for i=1:windowsize-stepsize
        sum=sum+absaudio(L-windowsize+stepsize+i);
end
if sum/windowsize>=threshold
    for i=1:windowsize-stepsize
    conditionedaudio(conditionedlength+i)=originalaudio(L-windowsize+stepsize+i);
    index=index+1;
    end
end
end