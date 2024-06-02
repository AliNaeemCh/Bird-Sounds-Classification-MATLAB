function zcrcmp(birdaudio)
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
    zcrarray(i)=mean(birdaudio((i-1)*get_total_audios_per_bird+1).zcr(1,:));
end

xaxis=1:gettotalbirds;
s=scatter(xaxis,zcrarray,'b','pentagram','filled');
s.SizeData=600;
set(gca,'xtick',[1:gettotalbirds],'xticklabel',birdname)
set(gca,'FontSize',15);
title('ZCR Values of Different Bird Sounds')
xlabel('Bird Name')
ylabel('ZCR Value')
end