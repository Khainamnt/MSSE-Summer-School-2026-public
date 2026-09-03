
source /usr/local/gromacs/bin/GMXRC
gmx grompp -f em.mdp -p topol.top -c preem.solvate.gro -o em.tpr 
gmx mdrun -v -deffnm em
gmx grompp -f npt.mdp -p topol.top -c em.gro -o npt.tpr -r preem.gro -maxwarn 5
gmx mdrun -v -deffnm npt
gmx grompp -f nvt.mdp -p topol.top -c npt.gro -o nvt.tpr -r preem.gro -maxwarn 5
gmx mdrun -v -deffnm nvt
