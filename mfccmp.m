function mfccmp(birdaudio,birdstocmp,totalframestocmp)
if ~exist('totalframestocmp','var')
      totalframestocmp = 2;   
end
total_birdstocmp=length(birdstocmp);
audiocount=0;
for i=1:total_birdstocmp
    birdname(i)=string(birdaudio((birdstocmp(i)-1)*get_total_audios_per_bird+1).filename);
    x=char(birdname(i));
    birdname(i)='';
    for j=1:length(x)
        if x(j)~=' '
            birdname(i)=strcat(birdname(i),x(j));
        else
            break;
        end
    end
    for j=(birdstocmp(i)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(i)
        audiocount=audiocount+1;
        framestocmp(audiocount,:)=pickframes(birdaudio(j).windowed,totalframestocmp);
    end
end
audiocount=0;
if total_birdstocmp==1
    for i=(birdstocmp(1)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(1)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount),', Frame: ' num2str(framestocmp(audiocount,j))];
            if audiocount==1
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==2
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==3
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
            end
           hold on 
        end
    end
    title(['MFCCs of Bird: ',birdname(1)])
    xlabel('Coefficient')
    ylabel('MFCC Value')
    set(gca,'fontsize',15)
    legend
elseif total_birdstocmp==2
    %bird 1
    for i=(birdstocmp(1)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(1)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 211
            if audiocount==1
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==2
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==3
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(1)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    %bird 2
    for i=(birdstocmp(2)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(2)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 212
            if audiocount==4
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==5
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==6
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(2)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    elseif total_birdstocmp==3
    %bird 1
    for i=(birdstocmp(1)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(1)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 311
            if audiocount==1
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==2
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==3
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(1)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    %bird 2
    for i=(birdstocmp(2)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(2)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 312
            if audiocount==4
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==5
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==6
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(2)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    %bird 3
    for i=(birdstocmp(3)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(3)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird*2),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 313
            if audiocount==7
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==8
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==9
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(3)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    elseif total_birdstocmp==4
    %bird 1
    for i=(birdstocmp(1)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(1)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 221
            if audiocount==1
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==2
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==3
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(1)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    %bird 2
    for i=(birdstocmp(2)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(2)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 222
            if audiocount==4
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==5
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==6
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(2)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
    %bird 3
    for i=(birdstocmp(3)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(3)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird*2),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 223
            if audiocount==7
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==8
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==9
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(3)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
        %bird 4
    for i=(birdstocmp(4)-1)*get_total_audios_per_bird+1:get_total_audios_per_bird*birdstocmp(4)
        audiocount=audiocount+1;
        for j=1:totalframestocmp
            frameno= ['Audio ',num2str(audiocount-get_total_audios_per_bird*3),', Frame: ' num2str(framestocmp(audiocount,j))];
            subplot 224
            if audiocount==10
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'linewidth',2,'DisplayName',frameno)
            elseif audiocount==11
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'--','linewidth',2,'DisplayName',frameno)
            elseif audiocount==12
                plot(birdaudio(i).mfccs(framestocmp(audiocount,j),:),'-.o','linewidth',2,'DisplayName',frameno)
                title(['MFCCs of Bird: ',birdname(4)])
                xlabel('Coefficient')
                ylabel('MFCC Value')
                set(gca,'fontsize',15)
                legend
            end
           hold on 
        end
    end
end
end