function disptheta(theta)
markers = {'o', '+', '*', '.', 'x', 's', 'd', '^', 'v', '>', '<', 'p', 'h'};
l_markers=length(markers);
lineStyles = {'-', '--', ':', '-.'};
l_lineStyles=length(lineStyles);
t=1;
for i=1:gettotalbirds
   plot(theta(:,i),'linewidth',2,'DisplayName',getbirdnames(i),'linestyle',lineStyles{t},'Marker', markers{i})
   if rem(i,l_lineStyles)==0
            t=0;
        end
        t=t+1;
   hold on
end
legend
legend('NumColumns', 2);
title('Weight Vectors of Defined Classes')
xlabel('Index')
ylabel('Value')
set(gca,'fontsize',15)
end