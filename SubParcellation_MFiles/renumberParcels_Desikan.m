function renumberParcels(path_subj,name)


%if (not(exist([path_subj 'parcellation/' name '_cortical_expanded_consecutive.nii.gz'])))
wmpar1=1; %New White matter label
wmpar2=20;
%volNif=load_nifti([path_subj 'parcellation/' name '.nii.gz']);
volNif=load_nifti([path_subj 'parcellation/' name '.nii.gz']);
save_nifti(volNif,[path_subj 'parcellation/' name '_orig.nii.gz']);
vol=volNif.vol;
volOrig=vol;
vol(find(vol==72))=31; %Change 5th ventricule for plexus choroideus
vol(find(vol==80))=0;
vol(find(vol==29))=0;

volMod=vol;
volNif.vol=vol;
save_nifti(volNif,[path_subj 'parcellation/' name '.nii.gz']);
bars_pos=strfind(path_subj,'/');

volNif2=volNif;
volNif2.vol=volOrig-volMod;
%{
vol_expNif=load_nifti([path_subj 'parcellation/' name '_expanded.nii.gz']);
vol_exp=vol_expNif.vol;
vol_exp(find(vol_exp==72))=31;
vol_exp(find(vol_exp==80))=0;
vol_exp(find(vol_exp==29))=0;

vol_expNif.vol=vol_exp;
save_nifti(vol_expNif,[path_subj 'parcellation/' name '_expanded.nii.gz']);
%}
volRenum=zeros(size(vol));
volRenum_exp=zeros(size(vol));
parcels=unique(vol);
numParcels=size(parcels,1);
limitSub_array=find(parcels<1001);
limitSub=limitSub_array(end)-1;      %%This number is the last subcortical
%system(['echo ' num2str(limitSub) ' > ' path_subj 'parcellation/boundary_sub_lh.txt']);
limitHemi_array=find(parcels<2001);
limitHemi=limitHemi_array(end)-1;    %%This number is the last lh
%system(['echo ' num2str(limitHemi) ' > ' path_subj 'parcellation/boundary_lh_rh.txt']);
volP=vol;
volP(find(vol<1001))=0;
volP(find(vol<1001))=0;
for i=2:numParcels
   voxParcel=find(vol==parcels(i));
   volRenum(voxParcel)=i-1;
   %Extended
%   voxParcel_exp=find(vol_exp==parcels(i));
%   volRenum_exp(voxParcel_exp)=i-1;
   
end
%Renum
volRenumNif=volNif;
volRenumNif.vol=volRenum;


%Renum parts
vol=volRenum;


%Cortical start in 1
newVol=vol;
newVol(newVol<limitSub+1)=0;
newVol(newVol==wmpar1)=0;
newVol(newVol==wmpar2)=0;
newVol=newVol-limitSub;
newVol(find(newVol<0))=0;

%eliminar 4,35,40 de vol
newVol(newVol==36)=0;
newVol(newVol==4)=0;
newVol(newVol==40)=0;
numelFinal=numel(unique(newVol(:)));
ind=1;
for i=1:max(newVol(:))
    if sum(sum(sum(newVol==i)))>0
        newVol(newVol==i)=ind;
        ind=ind+1;       
    end
end
volRenumNif.vol=newVol;
save_nifti(volRenumNif,[path_subj 'parcellation/' name '_cortical_consecutive.nii.gz']);


