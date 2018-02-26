function checkNumParcelsInd(path,expectedNum)
        vol=load_nifti(path);
        listlabel=size(unique(vol.vol),1)-1;
        if not(listlabel==expectedNum)
            path
           ERROR 
        end
end