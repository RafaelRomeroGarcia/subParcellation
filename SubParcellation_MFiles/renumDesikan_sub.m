function renumDesikan(path_nii,subcortical)

[dummy path_fs]=system('echo $FREESURFER_HOME')
addpath([path_fs '/matlab']);

v_orig=load_nifti(path_nii);
v=v_orig.vol;
v_out=zeros(size(v));
uv=unique(v);
if max(uv)>5000
    %If DK parcellation extended
   v(v==5001)=0; 
   v(v==5002)=0; 
   %v(v>=4000)=0;
   nregs_lh=sum((uv>1000) .* (uv<2000))+1; %35 regions because CC is a ga
   nregs_rh=sum((uv>2000) .* (uv<3000))+1; %35 regions because CC is a gap
   nregs=max(nregs_lh,nregs_rh);
   for ireg=1:nregs
       v(v==(3000+ireg))=1000+ireg; 
       v(v==(4000+ireg))=2000+ireg; 
   end
   uv=unique(v); 
end

maxLeft=1001+(sum((uv>1000) .* (uv<2000)));
reg_sub=[10:13 17:18 26 28 49:54 58 60];

reg_cor=[1001:maxLeft 2001:max(uv)];
ind=1;
for ic=1:numel(reg_cor)
    pos=find(v==reg_cor(ic));
    if isempty(pos)
       pos; 
    else
        v_out(pos)=ind;  
        ind=ind+1;
    end
end

v_out_nifty=v_orig;
v_out_nifty.vol=v_out;

%SAVE cortical
%save_nifti(v_out_nifty,[path_out '/' name '_cortical_consecutive.nii.gz']);
save_nifti(v_out_nifty,[path_nii(1:end-7) '_seq.nii.gz']);
if subcortical==1
    ind=1;
    v_out=zeros(size(v));
    reg_sub_cor=[reg_sub reg_cor];
    for ic=1:numel(reg_sub_cor)
        pos=find(v==reg_sub_cor(ic));
        if isempty(pos)
           pos; 
        else
            v_out(pos)=ind;  
            ind=ind+1;
        end
    end

    v_out_nifty=v_orig;
    v_out_nifty.vol=v_out;


    display(['Saving nifty' path_nii(1:end-7) '_seq.nii.gz']) 
    save_nifti(v_out_nifty,[path_nii(1:end-7) '_seq.nii.gz']);
end
end