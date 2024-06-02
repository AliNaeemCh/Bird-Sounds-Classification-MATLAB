function dispmfccspect(mfccs)
[totalframes,melbands]=size(mfccs);
temporalbinsize=(getframesize/getFs);         %Duration of 1 frame
temporalbins=[];
for i=1:totalframes
    temporalbins(i)=(i-1)*temporalbinsize;
end
if melbands>13
    mfccs=mfccs(:,1:13);
end
mfcc=1:melbands;
    contourf(temporalbins,mfcc,transpose(mfccs))
    title('MFCCs')
    xlabel('Time (s)')
    ylabel('MFCC Coefficient')
    %Y label will only be true if the mfccs start from MFCC 1
    c = colorbar;
    c.Label.String = 'Magnitude (dB)';
    set(gca,'fontsize',15)
    ax=gca;
    ax.YGrid='on';
    set(gca,'Linewidth',2)
end