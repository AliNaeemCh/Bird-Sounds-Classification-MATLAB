function testclassifier(featurevectorin)
weightvector=getweightvector;
bvector=getbvector;
featurevectorin=transpose(featurevectorin);
totalfeatures=size(featurevectorin,2);
data_percent_for_testing=0.2;
totaltestingfiles=floor((get_total_audios_per_bird*gettotalbirds)*data_percent_for_testing);      % 20% files are being used for testing
featurevectorfortesting=zeros(totaltestingfiles,totalfeatures);
files_for_testing_per_bird=get_total_audios_per_bird*data_percent_for_testing;
files_to_skip=get_total_audios_per_bird-files_for_testing_per_bird;
labelvector=zeros(totaltestingfiles,1);
cost=zeros(gettotalbirds,1);
index1=0;
i=files_to_skip;
while i<get_total_audios_per_bird*gettotalbirds
    for j=1:files_for_testing_per_bird
        featurevectorfortesting(index1+j,:)=featurevectorin(i+j,:);
    end
    index1=index1+files_for_testing_per_bird;
    i=i+files_to_skip+files_for_testing_per_bird;
end
for k=1:gettotalbirds
    labelvector(:)=0;
    labelvector((k-1)*files_for_testing_per_bird+1:(k-1)*files_for_testing_per_bird+files_for_testing_per_bird)=1;
    for i=1:totaltestingfiles
        cost(k)=cost(k)+(labelvector(i)-yesorno(featurevectorfortesting(i,:)*transpose(weightvector(k,:))+bvector(k)))^2;
    end
    disp(['Accuracy for Bird "',num2str(getbirdnames(k)),'" = ',num2str(100-(cost(k)/totaltestingfiles)*100),'%'])
end
disp(' ')
disp(['Total Decisions Made: ',num2str(gettotalbirds*totaltestingfiles)])
disp(['Decisions Made Correctly: ',num2str(gettotalbirds*totaltestingfiles-sum(cost))])
disp(['Decisions Made Inorrectly: ',num2str(sum(cost))])
disp(['Overall Efficiency of Classifier: ',num2str( ( gettotalbirds*totaltestingfiles-sum(cost) ) / (gettotalbirds*totaltestingfiles) * 100 ),'%'])
end