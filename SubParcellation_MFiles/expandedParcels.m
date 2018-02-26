function expandedParcels(path_subj,area,dilatationVoxel)
[path_subj '_Expanding volumetric parcellation...']
path_VolPar=[path_subj '/parcellation/' num2str(area) '.aparc'];
path_WM=[path_subj '/mri/wm.'];
c_convert_1=['mri_convert -it mgz -ot nii ' path_WM 'mgz '  path_WM 'nii ']
system(c_convert_1);
c_convert_2=['mri_convert -it mgz -ot nii ' path_subj '/mri/T1.mgz '  path_subj '/mri/T1.nii']
system(c_convert_2);
c_convert_3=['mri_convert -it mgz -ot nii ' path_subj '/mri/brainmask.mgz '  path_subj '/mri/brainmask.nii']
%system(c_convert_3);
volGM=load_nifti([path_VolPar '.nii.gz']);
volWM=load_nifti([path_WM 'nii']);
wmCode=[2,41];
parcelSet=unique(volGM.vol(:));
%Remove subcortical
newVol=volGM.vol;
parcelSetlh=find(volGM.vol==wmCode(1));
parcelSetrh=find(volGM.vol==wmCode(2));
parcelWhite=[parcelSetlh;parcelSetrh];


%%Calculate Centroid Parcels

parcelSet=parcelSet(parcelSet>1000);

for npar=1:size(parcelSet,1)
    parCod=parcelSet(npar);
    parVer=find(newVol==parCod);
    [ci cj ck]=ind2sub(size(newVol),parVer);
    centroids(npar,:)=[mean(ci) mean(cj) mean(ck)];
end

for nv=1:size(parcelWhite,1)
    nv
    parVer=parcelWhite(nv);
    [ci cj ck]=ind2sub(size(volGM.vol),parVer);
    candidates=[];
    for ni=-dilatationVoxel:dilatationVoxel
        for nj=-dilatationVoxel:dilatationVoxel
            for nk=-dilatationVoxel:dilatationVoxel
                nci=ci+ni;
                ncj=cj+nj;
                nck=ck+nk;
                if nci>0 & nci<257 & ncj>0 & ncj<257 & nck>0 & nck<257
                    if volGM.vol(nci,ncj,nck)>1000
                    candidates(end+1)=volGM.vol(nci,ncj,nck);
                    end
                end
            end
        end
        
    end
    candidates=unique(candidates)';
    distances=[];
    for nc=1:size(candidates,1)
        candPos=find(parcelSet==candidates(nc,1));
        distances(nc)=  power(centroids(candPos,1)-ci,2)+power(centroids(candPos,2)-cj,2)+power(centroids(candPos,3)-ck,2);
    end
    if not(isempty(distances))
        [v pos]=min(distances);
        newVol(ci,cj,ck)=candidates(pos);
    else
        newVol(ci,cj,ck)=volGM.vol(ci,cj,ck);
    end
end
volGM.vol=newVol;
save_nifti(volGM,[path_VolPar '_expanded_4mm.nii.gz']);
'Done!'
end