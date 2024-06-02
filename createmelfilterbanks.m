function melfilterbanks=createmelfilterbanks(melbands)
dftpoints=getFs/getresolution;
maxmel=hztomel(getFs/2);
spacing=maxmel/(melbands+1);
centerfreq=zeros(1,melbands+2);
centerfreq(end)=getFs/2;
for i=1:melbands
    centerfreq(i+1)=quantizeit(meltohz(spacing*i));
end
melfilterbanks=zeros(melbands,dftpoints/2+1);
for i=2:melbands+1
    slope=(1-0)/(centerfreq(i)-centerfreq(i-1));
    yint=-slope*centerfreq(i-1);
    for j=centerfreq(i-1):getresolution:centerfreq(i+1)
        if j==centerfreq(i)
            slope=(0-1)/(centerfreq(i+1)-centerfreq(i));
            yint=-slope*centerfreq(i+1);
        end
      melfilterbanks(i-1,(j/getresolution)+1)=slope*j+yint;
    end
end
end