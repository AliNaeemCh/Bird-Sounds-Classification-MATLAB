function mode=calcmode(data)
stdev=std(data);
total_elements=length(data);
datasorted=sort(data);
minval=datasorted(1);
maxval=datasorted(end);
binwidth=(3.5*stdev)/((total_elements)^(1/3));  %Scott's Rule for bin width
totalbins=floor((maxval-minval)/binwidth);
freq=zeros(1,totalbins+1);
if (maxval-minval)/binwidth>totalbins
    boundaryval=zeros(1,totalbins+2);
    boundaryval(end)=maxval;
else
    boundaryval=zeros(1,totalbins+1);
end
boundaryval(1)=minval;    
for i=2:totalbins+1
    boundaryval(i)=minval+binwidth*(i-1);
end
boundarycount=1;
datasamplecount=1;
while(datasamplecount<=total_elements)
    if datasorted(datasamplecount)~=maxval
        if datasorted(datasamplecount)>=boundaryval(boundarycount)&&datasorted(datasamplecount)<boundaryval(boundarycount+1)
            freq(boundarycount)=freq(boundarycount)+1;
        else
            boundarycount=boundarycount+1;
            datasamplecount=datasamplecount-1;
        end
    else
        if boundarycount~=length(freq)
            boundarycount=boundarycount+1;
        end
        freq(boundarycount)=freq(boundarycount)+1;
    end
    datasamplecount=datasamplecount+1;
end
[f1,modeindex]=max(freq);
L=boundaryval(modeindex);
if (modeindex-1)>0
    f0=freq(modeindex-1);
else
    f0=0;
end
if (modeindex+1)<length(freq)
    f2=freq(modeindex+1);
else
    f2=0;
end
mode=L+((f1-f0)/(2*f1-f0-f2))*binwidth;
end