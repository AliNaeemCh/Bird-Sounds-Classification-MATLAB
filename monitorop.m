%function monitorop
load('birdpictures')
load('cantidentify')
load('ready')
setbirdnames({'Montezuma Oropendola';'Koel';'Cuckoo';'Rook';'Nightjar';'Bullfinch';'Grey go-away-bird';'Barn Owl'});
counter=0;
nowshowing=false;
while(1)
    pause(0.05);
    copyfile bird.txt birdcopy.txt
    fileID = fopen('birdcopy.txt','r');
    bird_index=fscanf(fileID,'%d');
    fclose('all');
    
    if bird_index~=9
        if bird_index==0
            imshow(cantidentify);
            nowshowing=true;
        elseif bird_index~=bird_index_ex
            imshow(cell2mat(birdpictures(bird_index)));
            title(getbirdnames(bird_index))
            set(gca,'fontsize',15)
            nowshowing=true;
        end
        refreshdata;
    elseif nowshowing==true
        counter=counter+1;
        if counter>=60
            nowshowing=false;
            counter=0;
        end
    else
        imshow(ready);
    end
    bird_index_ex=bird_index;
end