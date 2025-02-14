#!/bin/bash

##-0- Define variables
wDIR=/mnt/shared/scratch/mlu/Chp1/fsc28_simulation
appDIR=/mnt/apps/users/mlu/fsc28_linux64
cd $wDIR


# ls $wDIR/*par > PARlist.txt
##----------- $wDIR/PARlist.txt -----------##
# /mnt/shared/scratch/mlu/Chp1/fsc28_simulation/DIV_ancient.par
# /mnt/shared/scratch/mlu/Chp1/fsc28_simulation/DIV_recent.par
# /mnt/shared/scratch/mlu/Chp1/fsc28_simulation/IM.par




##-0- Set up array job input
echo $SLURM_ARRAY_TASK_ID
PAR=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' $wDIR/PARlist.txt)



##-1- Run
time $appDIR/fsc28 -i "$PAR" -n1 -j -d -s0 -x –I -q -c8 -B8 -k 5000000
# -n: Number of simulations to perform per parameter file
# -j: Output per file in a separate directory
# -d: Computes the site frequency spectrum (SFS) for the derived alleles for each population sample and for all pairs of samples (joint 2D SFS). Note that this is only option when simulating DNA data.
# -s0: Output DNA as SNP data; s0 to output all SNPs in the DNA sequence(s)
# -x: Do not generate Arlequin output files (which take large space)
# -I: Generates DNA mutations according to an infinite site (IS) mutation model. Under this model, each mutation is supposed to occur at a different but random site on the DNA sequence
# -q: Quiet mode
# -c: Number of cores
# -B: Number of batches
# -k: Number of simulated polymorphic sites to keep in memory before writing them to temporary files.




