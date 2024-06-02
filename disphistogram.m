function disphistogram(data)
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
totalboundaryvals=length(boundaryval);
for i=1:totalboundaryvals-1
    xaxis(i)=string(strcat(num2str(round(boundaryval(i),2)),'—',num2str(round(boundaryval(i+1),2))));
end
bar(freq)
set(gca,'xtick',[1:length(xaxis)],'xticklabel',xaxis)
set(gca,'FontSize',15);
title('Histogram')
xlabel('Bin')
ylabel('Frequency')
end