path_sub='/root/trabajo/freesurfer/subjects/CNTRL_MCI_average/';
%HEMISFERIO IZQUIERDO
%path_annot_lh=strcat(path_sub,'label/lh.adaptada.aparc.annot');
path_annot_lh=strcat(path_sub,'label/lh.new.aparc.annot');
path_curv_thickness_lh=strcat(path_sub,'surf/lh.thickness');

%path_curv_area_lh=strcat(path_sub,'surf/lh.area');
path_curv_area_lh= strcat(path_sub,'surf/lh.white.avg.area.mgh');

path_surf_lh=strcat(path_sub,'surf/lh.white');


%HEMISFERIO DERECHO
%path_annot_rh=strcat(path_sub,'label/rh.adaptada.aparc.annot');
path_annot_rh=strcat(path_sub,'label/rh.new.aparc.annot');
path_curv_thickness_rh=strcat(path_sub,'surf/rh.thickness');

%path_curv_area_rh=strcat(path_sub,'surf/rh.area');
path_curv_area_rh= strcat(path_sub,'surf/rh.white.avg.area.mgh');
path_surf_rh=strcat(path_sub,'surf/rh.white');

[volThicknesslh,faces]=read_curv(path_curv_thickness_lh);

%[volArealh,faces]=read_curv(path_curv_area_lh);
[volArealh,faNumVertlhces]=load_mgh(path_curv_area_lh);
[verticeslh, newLabellh, newColorTablelh]=read_annotation(path_annot_lh);

[volThicknessrh,faces]=read_curv(path_curv_thickness_rh);

%[volArearh,faces]=read_curv(path_curv_area_rh);
[volArearh,faNumVertrhces]=load_mgh(path_curv_area_rh);

[verticesrh, newLabelrh, newColorTablerh]=read_annotation(path_annot_rh);
indlh=1;
indrh=1;
flag=1;
indfus=0;
for equ=1:35,
    NumVertlhReg(equ,1)=0;
    SurfArealhReg(equ,1)=0;
    ThicknesslhReg(equ,1)=0;
end
while (indlh<=newColorTablelh.numEntries || indrh<=newColorTablerh.numEntries),    
    if(not((indlh>newColorTablelh.numEntries) || indrh>newColorTablerh.numEntries)) 
    if(cambioRegion(indlh,newColorTablelh.struct_names) && not(cambioRegion(indrh,newColorTablerh.struct_names)) || cambioRegion(indrh,newColorTablerh.struct_names) && not(cambioRegion(indlh,newColorTablelh.struct_names))),
      if(cambioRegion(indlh,newColorTablelh.struct_names) && not(cambioRegion(indrh,newColorTablerh.struct_names)))
          paralh=1;
          indlh=indlh;
          indrh=indrh+1;
          pararh=0;
      else 
          indrh=indrh;
          indlh=indlh+1;
          paralh=0;
          pararh=1;
      end
    else
      indrh=indrh+1;
      indlh=indlh+1;
      paralh=0;
      pararh=0;
    end
    else
      indrh=indrh+1;
      indlh=indlh+1;
      paralh=0;
      pararh=0;
    end
    if(indlh>newColorTablelh.numEntries) paralh=1; end
    if(indrh>newColorTablerh.numEntries) pararh=1; end
    if(flag) indlh=1;indrh=1;flag=0; end
    
    if(not(paralh))
        verticesRegionlh=extractRegion(newColorTablelh.table(indlh,5),newLabellh); 
        num=size(verticesRegionlh);
        Thicknesslh(indlh,1)=0;
        NumVertlh(indlh,1)=0;
        SurfArealh(indlh,1)=0;
        SurfAreaStdlh(indlh,1)=0;
        ThicknessStdlh(indlh,1)=0;
        ThicknessRegionAux=[];
        for j=1:num(2),
            verticelh=verticesRegionlh(j);
            NumVertlh(indlh,1)=NumVertlh(indlh,1)+1;
            SurfArealh(indlh,1)=SurfArealh(indlh,1)+volArealh(verticelh);
            ThicknessRegionAuxlh(j)=volThicknesslh(verticelh);
            Thicknesslh(indlh,1)=Thicknesslh(indlh,1)+volThicknesslh(verticelh);
            regAct=newColorTablelh.struct_names(indlh);
            regAct=sprintf('%s',regAct{:});
            coin1=regAct(1:7)-'unknown';
            coin2=regAct(1:8)-'corpusca';
            if(sum(abs(coin1))<4 || sum(abs(coin2))<4),
                NumVertlh(indlh,1)=-1;
                SurfArealh(indlh,1)=-1;
                ThicknessRegionAuxlh(j)=-1;
                Thicknesslh(indlh,1)=-1;
            end
            %equ=contarOriginal(indlh,newColorTablelh.struct_names);
            %verticelhReg=verticesRegionlh(j);
            %NumVertlhReg(equ,1)=NumVertlhReg(equ,1)+1;
            %SurfArealhReg(equ,1)=SurfArealhReg(equ,1)+volArealh(verticelh);
            %ThicknessRegionAuxlhReg(j)=volThicknesslh(verticelh);
            %ThicknesslhReg(equ,1)=ThicknesslhReg(equ,1)+volThicknesslh(verticelh);
        end
          
        Thicknesslh(indlh,1)=Thicknesslh(indlh,1)/num(2);
        ThicknessStdlh(indlh,1)=std(ThicknessRegionAuxlh);
    end
    if(not(pararh))
        verticesRegionrh=extractRegion(newColorTablerh.table(indrh,5),newLabelrh); 
        num=size(verticesRegionrh);
        Thicknessrh(indrh,1)=0;
        NumVertrh(indrh,1)=0;
        SurfArearh(indrh,1)=0;
        ThicknessStdrh(indrh,1)=0;
        ThicknessRegionAux=[];
        for j=1:num(2),
            verticerh=verticesRegionrh(j);
            NumVertrh(indrh,1)=NumVertrh(indrh,1)+1;
            SurfArearh(indrh,1)=SurfArearh(indrh,1)+volArearh(verticerh);
            ThicknessRegionAuxrh(j)=volThicknessrh(verticerh);
            Thicknessrh(indrh,1)=Thicknessrh(indrh,1)+volThicknessrh(verticerh);
            regAct=newColorTablerh.struct_names(indrh);
            regAct=sprintf('%s',regAct{:});
            coin1=regAct(1:7)-'unknown';
            coin2=regAct(1:8)-'corpusca';
            if(sum(abs(coin1))<4 || sum(abs(coin2))<4),
                NumVertrh(indrh,1)=-1;
                SurfArearh(indrh,1)=-1;
                ThicknessRegionAuxrh(j)=-1;
                Thicknessrh(indrh,1)=-1;
            end
        end
        Thicknessrh(indrh,1)=Thicknessrh(indrh,1)/num(2);
        ThicknessStdrh(indrh,1)=std(ThicknessRegionAuxrh);
    end

    %if (cambioRegion(indlh,newColorTablelh.struct_names) && cambioRegion(indrh,newColorTablerh.struct_names)),
    %    indfus=indfus+1;
    %    ThicknessFus(indrh,1)=0;
    %    NumVertFus(indrh,1)=0;
    %    SurfAreaFus(indrh,1)=0;
    %    ThicknessStdrh(indrh,1)=0;
    %    ThicknessRegionAux=[];
    %end
    
    SurfAreaTotal=[SurfArealh;SurfArearh];
    SurfAreaTotalLimpia=SurfAreaTotal(SurfAreaTotal>-1);
    SurfAreaTotalStd=std(SurfAreaTotalLimpia);
    SurfAreaMinTotal=min(SurfAreaTotalLimpia);
    SurfAreaMaxTotal=max(SurfAreaTotalLimpia);
    SurfAreaMediaTotal=mean(SurfAreaTotalLimpia);
end
xlswrite('SurfAreaTotalAverage.xls',SurfAreaTotalLimpia);