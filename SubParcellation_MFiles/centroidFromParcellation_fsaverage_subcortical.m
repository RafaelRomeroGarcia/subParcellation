
    path_par=['/home/rr480/FSFiles/fsaverageSubP/parcellation/'];
    par_name='500.aparc';
    file_output=[par_name '16_subcortical_centroids.txt'];
    
    vol=load_nifti([path_par par_name '.nii.gz']);
    uvol=unique(vol.vol);
    subcortical=[8 10 11 12 13 17 18 26 47 49 50 51 52 53 54 58]
    subcortical_names={'Cerebellum-Cortex','Thalamus-Proper','Caudate','Putamen','Pallidum','Hippocampus','Amygdala','Accumbens'};
    for iv=1:numel(subcortical)
        val=subcortical(iv);
        cmd=['fslstats ' path_par par_name '.nii.gz -l ' num2str(val-1)  ' -u ' num2str(val+1) ' -c >> ' path_par file_output ];
        system(cmd);
        
    end