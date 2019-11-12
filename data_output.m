%% load ERP dataset
ERP = pop_loaderp('filename','/BLPlab/FS_FS+/Analysis/SVF_ERP/grandaverage_SVF_FS+.erp'); % ERP file directory

%% parameter setting
opt_prefix  =  'FS_FS+';                % prefix of output file
opt_dir     =  fullfile(pwd,'data');    % output directory (which folder)
binlist     =  [22;24];                 % bin number
chlist      =  [21;27];                 % channel number
xmin        =  -200;                    % min time point
xmax        =  1200;                    % max time point
ydata       =  [];                      % matrix for output data

%% output data I
for i = 1:length(binlist)
    
    for j = 1:length(chlist)
        
        chan = chlist(j); 
        epoch_times = ERP.times;                                % time points of epoch
        xmin_idx = find(epoch_times == xmin);                   % index of min time point
        xmax_idx = find(epoch_times == xmax);                   % index of max time point
        time_seg = xmin_idx:xmax_idx;                           % number array from min index to max index
        ydata(j,:) = ERP.bindata(chan,time_seg,binlist(i));     % extract data <channel,time,bin>
    
    end;
    
    fname = [opt_prefix '_bin' num2str(binlist(i)) '.csv'];     % output file name
    opt_file = fullfile(opt_dir,fname);                         % output directory + file name
    csvwrite(opt_file,ydata);                                   % output as .csv file
    
end;

%% output data II
%{
for i = 1:length(binlist)
    
    for j = 1:length(chlist)
        
        chan = chlist(j); 
        epoch_times = ERP.times;
        xmin_idx = find(epoch_times == xmin);
        xmax_idx = find(epoch_times == xmax);
        time_seg = xmin_idx:xmax_idx;
        chlabel = ERP.chanlocs(chan).labels;                    % channel name
        ydata = ERP.bindata(chan,time_seg,binlist(i));
        
        fname = [opt_prefix '_bin' num2str(binlist(i)) '_' chlabel '.csv'];
        opt_file = fullfile(opt_dir,fname);
        csvwrite(opt_file,ydata);
    
    end;
      
end;
%}