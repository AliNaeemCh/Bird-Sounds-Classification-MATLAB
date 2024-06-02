function visil(originalaudio,Fs)       %VIsualizeSilencing
 if ~exist('Fs','var')
      Fs = getFs;     %Default Sampling Freq
 end
windowsize=300;
stepsize=30;
maxsilence=floor(getframesize/stepsize);    %Max Silence duration~25ms
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
                conditionedaudio((i-1)*stepsize+j-samplejump)=0;
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
conditionedlength=length(conditionedaudio);
tconditioned=linspace(0,conditionedlength/Fs,conditionedlength);
toriginal=linspace(0,L/Fs,L);
subplot 211
plot(toriginal,originalaudio)
title('Input Signal')
xlabel('Time (s)')
ylabel('Amplitude')
subplot 212
plot(tconditioned,conditionedaudio)
title('Conditioned Signal')
xlabel('Time (s)')
ylabel('Amplitude')
end