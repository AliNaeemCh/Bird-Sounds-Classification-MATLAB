function frameindices=pickframes(frames,totalframestopick)
all=false;
if ~exist('totalframestopick','var')
        all=true;
end
threshold=0.01*getamplitudescale;
[totalframes,framesize]=size(frames);
framecount=0;
if all==false
    while(framecount<totalframestopick)
        for i=1:totalframes
            if framecount<totalframestopick
                avg=sum(abs(frames(i,:)))/framesize;
                if avg>threshold
                    framecount=framecount+1;
                    frameindices(framecount)=i;
                end
            else 
                break;
            end
        end
        if framecount<totalframestopick
            threshold=threshold-threshold*0.2;
            framecount=0;
        end
    end
else
    begin=true;
    while(begin)
            for i=1:totalframes
                    avg=sum(abs(frames(i,:)))/framesize;
                    if avg>threshold
                        framecount=framecount+1;
                        frameindices(framecount)=i;
                    end
            end
            if framecount<ceil(0.5*totalframes)
                threshold=threshold-threshold*0.2;
                framecount=0;
            else
                begin=false;
            end
    end
    end
end