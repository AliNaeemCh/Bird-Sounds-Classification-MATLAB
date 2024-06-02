function dispfv(birdaudio,featurevector,filestopick)
total_filestopick=length(filestopick);
for i=1:total_filestopick
    birdname(i)=string(birdaudio(filestopick(i)).filename);
    x=char(birdname(i));
    birdname(i)='';
    for j=1:length(x)
        if x(j)~=' '
            birdname(i)=strcat(birdname(i),x(j));
        else
            break;
        end
    end
end
for j=1:total_filestopick
    plot(featurevector(:,filestopick(j)),'linewidth',2,'DisplayName',birdname(j));
    hold on
end
legend
xaxis={'MFCC 2','MFCC 3','MFCC 4','MFCC 5','MFCC 6','MFCC 7','MFCC 8','MFCC 9','MFCC 10','△MFCC 1','△MFCC 2','△MFCC 3','△MFCC 4','△MFCC 5','△MFCC 6','△MFCC 7','△MFCC 8','ZCR','Spect. Cent.','SRO'};
totalfeatures=size(featurevector,1);
set(gca,'xtick',[1:totalfeatures],'xticklabel',xaxis)
title('Feature Vector of Bird(s)')
xlabel('Feature')
ylabel('Value')
set(gca,'fontsize',15)
end