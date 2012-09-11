%% draw flux data

% modified item
fluxsname='rainl';

cdfname=strcat('data-flux-0612/avXa2c_a_Faxa_',fluxsname,'.nc');
%ncdisp(cdfname)

regrid_distribution(cdfname,'nlatnlon','realdata')