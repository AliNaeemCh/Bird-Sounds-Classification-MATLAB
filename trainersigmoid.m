function theta=trainersigmoid(featurevectorin)
featurevectorin=transpose(featurevectorin);
data_percent_for_training=0.8;
totaltrainingexamples=ceil((get_total_audios_per_bird*gettotalbirds)*data_percent_for_training);      %80% files are being used for training
labelvector=zeros(totaltrainingexamples,1);
bvector=zeros(gettotalbirds,1);
bvector(:)=0.01;
featurevectorfortraining=zeros(totaltrainingexamples,gettotalfeatures);
files_for_training_per_bird=get_total_audios_per_bird*data_percent_for_training;
files_to_skip=get_total_audios_per_bird-files_for_training_per_bird;
index1=1;
index2=1;
while index1<get_total_audios_per_bird*gettotalbirds
   featurevectorfortraining(index2,:)=featurevectorin(index1,:);
   if rem(index2,files_for_training_per_bird)==0
       index1=index1+files_to_skip;
   end
   index1=index1+1;
   index2=index2+1;
end
for k=1:gettotalbirds
    alpha=0.75;
    labelvector(:)=0;
    labelvector((k-1)*files_for_training_per_bird+1:(k-1)*files_for_training_per_bird+files_for_training_per_bird)=1;
    weightvector(k,:)=randn(1,gettotalfeatures);
    wtranspose=transpose(weightvector(k,:));
    cost=0;
    for i=1:totaltrainingexamples
        cost=cost+(labelvector(i)-gsigmoid(featurevectorfortraining(i,:)*wtranspose+bvector(k)))^2;
    end
    costex=cost;
    diffw=zeros(1,gettotalfeatures);
    count=1;
    while cost>0.01
        if cost>costex
            disp(['Increase in Cost Value Detected while training of bird: ',num2str(getbirdnames(k))]);
            alpha=alpha/2;
        end
        for j=1:gettotalfeatures
            diffw(:)=0;
            diffb=0;
               for i=1:totaltrainingexamples
                   prediction=gsigmoid(featurevectorfortraining(i,:)*wtranspose+bvector(k));
                   diffw(j)=diffw(j)+((labelvector(i)-prediction)*(-prediction)*(1-prediction)*featurevectorfortraining(i,j));
                   diffb=diffb+((labelvector(i)-prediction)*(-prediction)*(1-prediction));
               end
               diffb=diffb/totaltrainingexamples;
               bvector(k)=bvector(k)-alpha*diffb;
               diffw(j)=diffw(j)/totaltrainingexamples;
               weightvector(k,j)=weightvector(k,j)-alpha*diffw(j);
               wtranspose=transpose(weightvector(k,:));
        end
        costex=cost;
        cost=0;
        for i=1:totaltrainingexamples
            cost=cost+(labelvector(i)-gsigmoid(featurevectorfortraining(i,:)*wtranspose+bvector(k)))^2;
        end
        if rem(count,1000)==0
            disp(['Training Classifier for Bird: "',num2str(getbirdnames(k)),'". Cost Value = ',num2str(cost)]);
            if (costex-cost)<0.1
                alpha=2*alpha;
            end
            if (costex-cost)<0.0000001
              disp(['Unable to Minimize Cost for Bird: "',num2str(getbirdnames(k)),'". Final Cost Value = ',num2str(cost)]);
              break;
            end
        end
        count=count+1;
    end
    disp(['Classifier has been trained successfully for Bird: "',num2str(getbirdnames(k)),'" with total iterations = ',num2str(count)]);
end
weightvector=transpose(weightvector);
setweightvector(weightvector);
setbvector(bvector);
settheta(wbtotheta(getweightvector,getbvector));
theta=gettheta;
save('theta','theta');
dspkitupdate;
end