#!/bin/bash -x
#SBATCH --job-name=Na-M-d8
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --time=24:00:00
#SBATCH --partition=batchgpu
#SBATCH --gres=gpu:1
#SBATCH --output=out.%j
#SBATCH --error=err.%j

module purge
module load gcc/7.3.1
module load fftw/gcc/single/sse/3.3.8
module load cuda/9.2
module load gromacs/nompi/gpu/gcc/single/2018.2

gmx grompp -f em.mdp -p topol.top -c preem.solvate.gro -o em.tpr 
gmx mdrun -v -deffnm em -nb gpu
gmx grompp -f npt.mdp -p topol.top -c em.gro -o npt.tpr -r preem.gro -maxwarn 5
gmx mdrun -v -deffnm npt -nb gpu
gmx grompp -f nvt.mdp -p topol.top -c npt.gro -o nvt.tpr -r preem.gro -maxwarn 5
gmx mdrun -v -deffnm nvt -nb gpu
