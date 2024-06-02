function dspkitupdate
load maxval
load minval
load avg
write2darray(single(gettheta),'theta','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\theta.h',45,{'totalfeatures+1','totalclasses'});
write1darray(single(maxval),'maxval','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\maxval.h',45,'totalfeatures');
write1darray(single(minval),'minval','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\minval.h',45,'totalfeatures');
write1darray(single(avg),'avg','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\avg.h',45,'totalfeatures');
write2darray(single(getmelfilterbanks),'melfilterbanks','D:\Study\My Documents\FYP\FYP-III\WORK FILES\Code Composer Studio\DSP KIT WORKSPACE\DSP KIT FINAL YEAR PROJECT\melfilterbanks.h',45,{'totalmelfilterbanks','dftvals'});
fclose('all');
end