function vismelbanks(melfilterbanks)
totalbanks=size(melfilterbanks,1);
freqHz=0:getresolution:getFs/2;
for i=1:totalbanks
    plot(freqHz,melfilterbanks(i,:),'linewidth',2)
    hold on
end
title('Mel Filter Banks')
xlabel('f (Hz)')
ylabel('H(f)')
set(gca,'fontsize',25)
end
    
