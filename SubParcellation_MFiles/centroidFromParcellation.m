clear
path_folder_donors='/home/rr480/FSFiles/subjects/Allen/';
dir_sub=dir(path_folder_donors);
for is=3:numel(dir_sub)-1
    path_par=['/home/rr480/FSFiles/subjects/Allen/' dir_sub(is).name '/parcellation/'];
    par_name='aparc+aseg_consecutive_brain';
    file_output=[par_name '_centroids.txt'];
    
    vol=load_nifti([path_par par_name '.nii.gz']);
    uvol=unique(vol.vol);
    
    for iv=2:numel(uvol)
        val=uvol(iv);
        cmd=['fslstats ' path_par par_name '.nii.gz -l ' num2str(val-1)  ' -u ' num2str(val+1) ' -c >> ' path_par file_output ];
        system(cmd);
        
    end
end