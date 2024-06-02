function hz=meltohz(mel)
hz=700*(10^(mel/2595)-1);
end