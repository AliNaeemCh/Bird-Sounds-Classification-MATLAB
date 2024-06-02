function generatefiles(originalaudio,Fs,silenceinsec,filename)

%Silencing the Noise%
windowsize=300;
stepsize=30;
maxsilence=Fs*silenceinsec; 
L=length(originalaudio);
threshold=0.01;
boundarytime=0.2;
R=rem(L,windowsize);
if R~=0
    zerospadded=windowsize-R;
    for i=1:zerospadded
        originalaudio(L+i)=0;
    end
    L=L+zerospadded;
end
out=[];
absaudio=abs(originalaudio);
totaliterations=((L-windowsize)/stepsize)+1;
zeroflag=0;
outindex=1;
fileindex=1;
recover=true;
for i=1:totaliterations
    sum=0;
    for j=1:windowsize
        sum=sum+absaudio((i-1)*stepsize+j);
    end
    if sum/windowsize<threshold
        if zeroflag<maxsilence
            if recover==false
                for j=1:stepsize
                out(outindex)=originalaudio((i-1)*stepsize+j);
                outindex=outindex+1;
                end
            end
            zeroflag=zeroflag+stepsize;
        elseif length(out)>0
            out=out(1:end-maxsilence+ceil(boundarytime*Fs));
            audiowrite([filename,' ',num2str(fileindex),'.wav'],out,Fs);
            fileindex=fileindex+1;
            outindex=1;
            recover=true;
            clear out
            out=[];
        end
    else
            if recover==true
                if ( (i-1)*stepsize-ceil(boundarytime*Fs) )>=1
                    out=originalaudio((i-1)*stepsize-ceil(boundarytime*Fs):(i-1)*stepsize);
                    outindex=length(out)+1;
                end
                recover=false;
            end
            for j=1:stepsize
                    out(outindex)=originalaudio((i-1)*stepsize+j);
                outindex=outindex+1;
            end
            zeroflag=0;
    end
end
% sum=0;
% conditionedlength=length(out);
% for i=1:windowsize-stepsize
%         sum=sum+absaudio(L-windowsize+stepsize+i);
% end
% if sum/windowsize>=threshold
%     for i=1:windowsize-stepsize
%     out(conditionedlength+i)=originalaudio(L-windowsize+stepsize+i);
%     end
% end
end
