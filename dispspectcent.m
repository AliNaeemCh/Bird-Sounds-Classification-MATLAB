function dispspectcent(birdaudio,birdstopick)
all=false;
 if ~exist('birdstopick','var')
      all=true;
 end
if all==true
    total_birdstopick=size(birdaudio,2)/get_total_audios_per_bird;
    for i=1:total_birdstopick
        birdstopick(i)=i;
    end
else
    total_birdstopick=length(birdstopick);
end
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
    for j=1:total_birdstopick
        plot(birdaudio((birdstopick(j)-1)*get_total_audios_per_bird+1).spectralcentroid,'linewidth',2,'DisplayName',birdname(j));
        hold on
    end
legend
title('Spectral Centroid of Bird Audio(s)')
xlabel('Frame')
ylabel('Centroid (Hz)')
set(gca,'fontsize',15)
end