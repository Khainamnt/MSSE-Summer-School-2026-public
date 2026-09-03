# Commands — methane coexistence (Part 2)

## Core pipeline

```text
  .gro  +  .top  +  .mdp  →  gmx grompp  →  .tpr  →  gmx mdrun  →  outputs
```

| Stage | Role |
|-------|------|
| **EM** | Energy minimisation — remove bad contacts |
| **NVT** | Equilibrate at target T |
| **Production** | Sample (here: NVT slab, no barostat) |
| **Analysis** | `gmx density`, `gmx energy`, … |

```bash
cd part2_gromacs

# Inspect (shipped)
head structures/slab_start.gro
cat FF/lj_methane.itp
less MDP/prod_template.mdp

# --- Live short path (scratch folders) ---
mkdir -p em nvt prod analysis

# Stage 1 — EM
gmx grompp -f MDP/em.mdp -c structures/slab_start.gro -p inputs/topol.top -o em/em.tpr
gmx mdrun  -deffnm em/em -nt 4

# Stage 2 — NVT (example T = 130 K)
gmx grompp -f MDP/nvt_T130.mdp -c em/em.gro -p inputs/topol.top -o nvt/nvt_T130.tpr
gmx mdrun  -deffnm nvt/nvt_T130 -nt 4

# Stage 3 — production (optional in room; use -t to continue from .cpt)
gmx grompp -f MDP/prod_T130.mdp \
  -c nvt/nvt_T130.gro -t nvt/nvt_T130.cpt \
  -p inputs/topol.top -o prod/prod_T130.tpr
gmx mdrun  -deffnm prod/prod_T130 -nt 4

# Student MDP edit example
cp MDP/prod_template.mdp MDP/prod_T140.mdp
# set ref_t = 140

# --- Precomputed analysis (shipped trajectories) ---
xmgrace precomputed/T_*/density_z.xvg -legend load

echo 0 | gmx density -f precomputed/T_130/prod.xtc -s precomputed/T_130/prod.tpr -d Z -o analysis/density_T130.xvg
echo Temperature | gmx energy -f precomputed/T_130/prod.edr -o analysis/T_T130.xvg
```

For the VLCC (vapour–liquid coexistence curve) and classroom \(T_c\) scaling fit, use the Python cells in `LJ_coexistence_GROMACS.ipynb` (110–140 K). TraPPE target methane \(T_c \approx 190\,\mathrm{K}\).

Scratch folders (`em/`, `nvt/`, `prod/`, `analysis/`) are local run outputs — safe to delete; keep `precomputed/`.

## Temperatures (kelvin)

Stay below methane Tc ≈ 190 K. UA methane (TraPPE-like).

| T (K) | Folder |
|-------|--------|
| 110 | `precomputed/T_110/` |
| 120 | `precomputed/T_120/` |
| 130 | `precomputed/T_130/` |
| 140 | `precomputed/T_140/` |
| 150 | `precomputed/T_150/` |
| 170 | `precomputed/T_170/` |
