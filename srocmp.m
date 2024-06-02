function srocmp(birdaudio)
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
    sroarray(i)=mean(birdaudio((i-1)*get_total_audios_per_bird+1).sro(1,:));
end

xaxis=1:gettotalbirds;
bar(xaxis,sroarray);
set(gca,'xtick',[1:gettotalbirds],'xticklabel',birdname)
set(gca,'FontSize',15);
title('Spectral Roll-off of Different Bird Sounds')
xlabel('Bird Name')
ylabel('Spectral Roll-off (Hz)')
end