#!/bin/sh

#SBATCH --partition=Orion
#SBATCH --job-name=cford_vivax_transcriptome
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=100:00:00

echo "======================================================"
echo "Start Time  : $(date)"
echo "Submit Dir  : $SLURM_SUBMIT_DIR"
echo "Job ID/Name : $SLURM_JOBID : $SLURM_JOB_NAME"
echo "Node List   : $SLURM_JOB_NODELIST"
echo "Num Tasks   : $SLURM_NTASKS total [$SLURM_NNODES nodes @ $SLURM_CPUS_ON_NODE CPUs/node]"
echo "======================================================"
echo ""

### choose an R version
#VER=3.4.3
#VER=3.5.0
VER=3.6.0

module load R/${VER}
cd $SLURM_SUBMIT_DIR
Rscript pipeline.R

echo ""
echo "======================================================"
echo "End Time   : $(date)"
echo "======================================================"
