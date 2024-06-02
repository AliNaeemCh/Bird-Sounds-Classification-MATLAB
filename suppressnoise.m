function audio=suppressnoise(audio,info,Fs)
if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
end
%Resampling
if exist('info','var')
    if(info.SampleRate~=Fs)
    audio=resample(audio,Fs,info.SampleRate);
    end
end
%Silencing the Noise%
windowsize=300;
stepsize=30;
L=length(audio);
threshold=0.01;
R=rem(L,windowsize);
if R~=0
    zerospadded=windowsize-R;
    for i=1:zerospadded
        audio(L+i)=0;
    end
    L=L+zerospadded;
end
absaudio=abs(audio);
totaliterations=((L-windowsize)/stepsize)+1;
for i=1:totaliterations
    if(sum(absaudio((i-1)*stepsize+1:windowsize+(i-1)*stepsize))/windowsize<threshold)
        audio((i-1)*stepsize+1:stepsize*i)=0;
    end
end
if(sum(absaudio((L-(windowsize-stepsize)+1:L)))/(windowsize-stepsize)<threshold)
    audio((L-(windowsize-stepsize)+1:L))=0;
end
end