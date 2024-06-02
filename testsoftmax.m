function testsoftmax(featurevectorin)
data_percent_for_testing=0.2;
theta=gettheta;
totaltestingfiles=floor((get_total_audios_per_bird*gettotalbirds)*data_percent_for_testing);      % 20% files are being used for testing
featurevectorfortesting=zeros(gettotalfeatures,totaltestingfiles);
files_for_testing_per_bird=get_total_audios_per_bird*data_percent_for_testing;
files_to_skip=get_total_audios_per_bird-files_for_testing_per_bird;
cost=zeros(gettotalbirds,1);
index1=0;
i=files_to_skip;
while i<get_total_audios_per_bird*gettotalbirds
    for j=1:files_for_testing_per_bird
        featurevectorfortesting(:,index1+j)=featurevectorin(:,i+j);
    end
    index1=index1+files_for_testing_per_bird;
    i=i+files_to_skip+files_for_testing_per_bird;
end
featurevectorfortesting(gettotalfeatures+1,:)=1;
Pden=zeros(1,totaltestingfiles);
Pnum=zeros(gettotalbirds,totaltestingfiles);
for j=1:totaltestingfiles
    for k=1:gettotalbirds
        Pden(j)=Pden(j)+exp(transpose(theta(:,k))*featurevectorfortesting(:,j));
    end
    Pnum(:,j)=exp(transpose(theta)*featurevectorfortesting(:,j));
    P(:,j)=Pnum(:,j)/Pden(j);
    [maxval,prediction(j)]=max(P(:,j));
end
birdindex=1;
    for i=1:totaltestingfiles
        cost(birdindex)=cost(birdindex)+(1-(prediction(i)==birdindex))^2;
        if rem(i,files_for_testing_per_bird)==0
            disp(['Accuracy for Bird "',num2str(getbirdnames(birdindex)),'" = ',num2str(100-(cost(birdindex)/files_for_testing_per_bird)*100),'%'])
            birdindex=birdindex+1;
        end
    end
disp(' ')
disp(['Total Decisions Made: ',num2str(gettotalbirds*files_for_testing_per_bird)])
disp(['Decisions Made Correctly: ',num2str(gettotalbirds*files_for_testing_per_bird-sum(cost))])
disp(['Decisions Made Inorrectly: ',num2str(sum(cost))])
disp(['Overall Efficiency of Classifier: ',num2str( ( gettotalbirds*files_for_testing_per_bird-sum(cost) ) / (gettotalbirds*files_for_testing_per_bird) * 100 ),'%'])
end