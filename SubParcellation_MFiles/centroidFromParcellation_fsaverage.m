
    path_par=['/home/rr480/FSFiles/fsaverageSubP/parcellation/'];
    par_name='500.aparc';
    file_output=[par_name '324_centroids.txt'];
    
    vol=load_nifti([path_par par_name '.nii.gz']);
    uvol=unique(vol.vol);
    
    for iv=2:numel(uvol)
        val=uvol(iv);
        cmd=['fslstats ' path_par par_name '.nii.gz -l ' num2str(val-1)  ' -u ' num2str(val+1) ' -c >> ' path_par file_output ];
        system(cmd);
        
    end