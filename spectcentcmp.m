function spectcentcmp(birdaudio)
for i=1:gettotalbirds
    birdname(i)=string(birdaudio((i-1)*get_total_audios_per_bird+1).filename);
        x=char(birdname(i));
        birdname(i)='';
        for j=1:length(x)
            if x(j)~=' '
                birdname(i)=strcat(birdname(i),x(j));
            else
                break;
            end
        end
    spectcentarray(i)=mean(birdaudio((i-1)*get_total_audios_per_bird+1).spectralcentroid(1,:));
end

xaxis=1:gettotalbirds;
bar(xaxis,spectcentarray);
set(gca,'xtick',[1:gettotalbirds],'xticklabel',birdname)
set(gca,'FontSize',15);
title('Spectral Centroid of Different Bird Sounds')
xlabel('Bird Name')
ylabel('Spectral Centroid (Hz)')
end