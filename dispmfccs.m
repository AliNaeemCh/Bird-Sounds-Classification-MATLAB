function dispmfccs(birdaudio,frames)
if ~exist('frames','var')
      frames=pickframes(birdaudio.windowed,3);    %By Default, MFCCs of 3 Frames will be displayed
elseif strcmp(frames,'all')
    frames=pickframes(birdaudio.windowed);
 end
totalframes=length(frames);
for i=1:totalframes
    y= ['Frame: ' num2str(frames(i))];
    plot(birdaudio.mfccs(frames(i),:),'linewidth',2,'DisplayName',y)
    hold on
end
birdname=string(birdaudio.filename);
x=char(birdname);
birdname='';
for j=1:length(x)
    if x(j)~=' '
        birdname=strcat(birdname,x(j));
    else
        break;
    end
end
xaxis={'MFCC 2','MFCC 3','MFCC 4','MFCC 5','MFCC 6','MFCC 7','MFCC 8','MFCC 9','MFCC 10','△MFCC 1','△MFCC 2','△MFCC 3','△MFCC 4','△MFCC 5','△MFCC 6','△MFCC 7','△MFCC 8'};
set(gca,'xtick',[1:gettotalmfccs+gettotaldelmfccs],'xticklabel',xaxis)
title(['MFCCs of Bird: ',birdname])
xlabel('Coefficient')
ylabel('MFCC Value')
set(gca,'fontsize',15)
legend
end