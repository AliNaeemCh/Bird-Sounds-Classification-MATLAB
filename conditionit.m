function conditionedaudio=conditionit(originalaudio,info,Fs)
if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
end
%Resampling%
if exist('info','var')
    if(info.SampleRate~=Fs)
    originalaudio=resample(originalaudio,Fs,info.SampleRate);
    end
end
%Silencing the Noise%
windowsize=300;
stepsize=30;
maxsilence=floor(getframesize/stepsize);    %Max Silence duration~Duration of 1 frame
L=length(originalaudio);
threshold=0.01*getamplitudescale;
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
zeroflag=0;
samplejump=0;
for i=1:totaliterations
    sum=0;
    for j=1:windowsize
        sum=sum+absaudio((i-1)*stepsize+j);
    end
    if sum/windowsize<threshold
        if zeroflag<maxsilence
            for j=1:stepsize
                conditionedaudio((i-1)*stepsize+j-samplejump)=0.0000000001;
            end
        zeroflag=zeroflag+1;
        else
            samplejump=samplejump+stepsize;
        end
        else
            for j=1:stepsize
                conditionedaudio((i-1)*stepsize+j-samplejump)=originalaudio((i-1)*stepsize+j);
            end
            zeroflag=0;
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
    end
end
end
