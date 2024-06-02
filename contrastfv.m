function contrastfv(birdaudio,featurevector,birdstopick)
all=false;
 if ~exist('birdstopick','var')
      all=true;
 end
if all==true
    total_birdstopick=gettotalbirds;
    for i=1:total_birdstopick
        birdstopick(i)=i;
    end
else
    total_birdstopick=length(birdstopick);
end
markers = {'o', '+', '*', '.', 'x', 's', 'd', '^', 'v', '>', '<', 'p', 'h'};
l_markers=length(markers);
lineStyles = {'-', '--', ':', '-.'};
l_lineStyles=length(lineStyles);
    for i=1:total_birdstopick
        birdname(i)=string(birdaudio((birdstopick(i)-1)*get_total_audios_per_bird+1).filename);
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
    t=1;
    for j=1:total_birdstopick
        plot(featurevector(:,(birdstopick(j)-1)*get_total_audios_per_bird+1),'linewidth',2,'DisplayName',birdname(j),'linestyle',lineStyles{t},'Marker', markers{j});
        if rem(j,l_lineStyles)==0
            t=0;
        end
        t=t+1;
        hold on
    end
legend
legend('NumColumns', 2);
xaxis={'MFCC 2','MFCC 3','MFCC 4','MFCC 5','MFCC 6','MFCC 7','MFCC 8','MFCC 9','MFCC 10','△MFCC 1','△MFCC 2','△MFCC 3','△MFCC 4','△MFCC 5','△MFCC 6','△MFCC 7','△MFCC 8','ZCR','Spect. Cent.','SRO'};
totalfeatures=size(featurevector,1);
set(gca,'xtick',[1:totalfeatures],'xticklabel',xaxis)
title('Feature Vector(s) of Class(es)')
xlabel('Feature')
ylabel('Value')
set(gca,'fontsize',15)
end