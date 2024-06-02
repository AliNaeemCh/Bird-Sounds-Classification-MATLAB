function dspkitmfbanksupdate(melfilterbanks)
write2darray(single(melfilterbanks),'melfilterbanks','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\melfilterbanks.h',45,{'totalmelfilterbanks','dftvals'});
fclose('all');
end