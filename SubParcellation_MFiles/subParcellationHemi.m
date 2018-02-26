function subParcellationHemi(subject,surface,hemi)
    if exist([subject '/label/subParcellation' hemi '_temp.mat']),
        closeVertex=load([subject '/label/subParcellation' hemi '_temp']);
        closeVertex=closeVertex.closeVertex;
    else
        closeVertex=closerVertex(subject,hemi);
        save([subject '/label/subParcellation' hemi '_temp' ],'closeVertex');
    end
    backtrackParcellation(subject,surface,closeVertex,hemi)
    checkParcels(hemi,subject,closeVertex,surface)
end