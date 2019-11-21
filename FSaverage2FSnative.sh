#!/bin/bash

#First paratemer $sub is the name of the folder of the subject that want to be processed
#Second parameter is the folder where the freesurfer folders are located

sub=$1
SUBJECTS_DIR=$2

fsaverage_subid=fsaverage
cd $SUBJECTS_DIR

if [ -f ${SUBJECTS_DIR}/${sub}/label/rh.aparc.annot ] && [ ! "${sub}" = 'fsaverageSubP' ]; then
	echo ${SUBJECTS_DIR}/${sub}
	for parcellation in 500.aparc ; do 
		for hemi in lh rh ; do
			if [ ! -f ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation}.annot ]; then
			mri_surf2surf --srcsubject ${fsaverage_subid} \
				            --sval-annot ${SUBJECTS_DIR}/${fsaverage_subid}/label/${hemi}.${parcellation} \
				            --trgsubject ${sub} \
				            --trgsurfval ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation} \
				            --hemi ${hemi}

			fi
		done

		if [ ! -f ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz ]; then
			mkdir ${SUBJECTS_DIR}/${sub}/parcellation/
			mri_aparc2aseg --s ${sub} \
                        	--o ${SUBJECTS_DIR}/${sub}/parcellation/${parcellation}.nii.gz \
                        	--annot ${parcellation} \
                        	--rip-unknown \
                        	--hypo-as-wm
		fi


		for hemi in lh rh ; do
			if [ ! -s ${SUBJECTS_DIR}/${sub}/stats/${hemi}.${parcellation}.log ]; then
		        mris_anatomical_stats -a ${SUBJECTS_DIR}/${sub}/label/${hemi}.${parcellation}.annot -b ${sub} ${hemi} > ${SUBJECTS_DIR}/${sub}/stats/${hemi}.${parcellation}.log
			fi
		done


	done
fi