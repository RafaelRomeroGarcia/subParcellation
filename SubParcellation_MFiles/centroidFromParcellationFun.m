function centroids=centroidFromParcellationFun(path_par,parcellation_name)
    vol=load_nifti([path_par parcellation_name]);
    uvol=unique(vol.vol);
    if not(exist([path_par '/' parcellation_name '_centroids.txt']))
        for iv=2:numel(uvol)
            val=uvol(iv);
            cmd=['fslstats ' path_par parcellation_name ' -l ' num2str(val-1)  ' -u ' num2str(val+1) ' -c >> ' path_par parcellation_name '_centroids.txt'  ];
            system(cmd);        
        end
    end
        centroids=importdata([path_par '/' parcellation_name '_centroids.txt']);
end
