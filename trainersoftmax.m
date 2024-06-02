function theta=trainersoftmax(featurevectorin)
data_percent_for_training=0.8;
totaltrainingexamples=ceil((get_total_audios_per_bird*gettotalbirds)*data_percent_for_training);      %80% files are being used for training
T=zeros(totaltrainingexamples,1);
theta=randn(gettotalfeatures+1,gettotalbirds);
featurevectorfortraining=zeros(gettotalfeatures,totaltrainingexamples);
files_for_training_per_bird=get_total_audios_per_bird*data_percent_for_training;
files_to_skip=get_total_audios_per_bird-files_for_training_per_bird;
index1=1;
index2=1;
while index1<get_total_audios_per_bird*gettotalbirds
   featurevectorfortraining(:,index2)=featurevectorin(:,index1);
   if rem(index2,files_for_training_per_bird)==0
       index1=index1+files_to_skip;
   end
   index1=index1+1;
   index2=index2+1;
end
featurevectorfortraining(gettotalfeatures+1,:)=1;
P=zeros(gettotalbirds,totaltrainingexamples);

cost=computecost;   %This sub-method is written at the end of this function 

costex=cost;
alpha=1;
count=0;
static=0;
while cost>0.01
    gradtheta=zeros(gettotalfeatures+1,gettotalbirds);
    if cost>costex
        disp('Increase in Cost Value Detected. Slowing Down the Learning Rate!');
        alpha=alpha/2;
    end
    for k=1:gettotalbirds
        T(:)=0;
        T((k-1)*files_for_training_per_bird+1:(k-1)*files_for_training_per_bird+files_for_training_per_bird)=1;
        for j=1:gettotalfeatures+1
            for i=1:totaltrainingexamples
               gradtheta(j,k)=gradtheta(j,k)+featurevectorfortraining(j,i)*(T(i)-P(k,i));
            end
        gradtheta(j,k)=-(1/totaltrainingexamples)*gradtheta(j,k);
        end
    end
    for k=1:gettotalbirds
        for j=1:gettotalfeatures+1
            theta(j,k)=theta(j,k)-alpha*gradtheta(j,k);
        end
    end
    costex=cost;
    cost=computecost;
    count=count+1;
    if rem(count,1000)==0
        disp(['Training in Progress! Iterations done= ',num2str(count),'. Learning Rate= ',num2str(alpha),'. Cumulative Cost Value= ',num2str(cost)]);
        if (costex-cost)<0.1
            alpha=2*alpha;
        end
        if (costex-cost)<0.0000001
            static=static+1;
            if static==10
                disp('Unable to Minimize Cost Further');
                break;
            end
        end
    end
end
disp(['Classifier has been trained successfully with total iterations= ',num2str(count)]);
disp(['Final Cumulative Cost Value for ',num2str(totaltrainingexamples*gettotalbirds),' Decisions= ',num2str(cost)]);
settheta(theta);
save('theta','theta')
dspkitupdate;

function cost=computecost
for i=1:totaltrainingexamples
    for k=1:gettotalbirds
       Pnum(k,i)=exp(transpose(theta(:,k))*featurevectorfortraining(:,i));
    end
    Pden(i)=sum(Pnum(:,i));
    for k=1:gettotalbirds
        P(k,i)=Pnum(k,i)/Pden(i);
    end
end
cost=0;
for k=1:gettotalbirds
    T(:)=0;
    T((k-1)*files_for_training_per_bird+1:(k-1)*files_for_training_per_bird+files_for_training_per_bird)=1;
    for i=1:totaltrainingexamples
        cost=cost+(T(i)*log(P(k,i)));
    end
end
cost=-cost;
end

end