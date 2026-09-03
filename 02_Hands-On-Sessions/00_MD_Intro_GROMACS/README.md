# Fundamentals of Molecular Simulations — GROMACS

**Day 1 afternoon · MSSE 2026**  
**Instructor:** [Dr Valentina Erastova](https://www.erastova.xyz/), University of Edinburgh  
**Contact:** [valentina.erastova@ed.ac.uk](mailto:valentina.erastova@ed.ac.uk)

One physical idea — **liquid–vapour coexistence** — in two tools. Part 1 is a widget-only Lennard-Jones applet (phases, interfaces, g(r), timestep). Part 2 is a GROMACS **united-atom methane** slab: edit the `.mdp`, read **precomputed** density profiles, and sketch a TraPPE-style vapour–liquid coexistence curve (VLCC).

Start here: **[STUDENT_GUIDE.md](STUDENT_GUIDE.md)** (setup checks live in that file, not in the notebooks).

---

## Learning outcomes

By the end of the session you should be able to:

- explain MD as forces → integrate → new positions, and why **Δt** must stay small;
- tell liquid from solid using **g(r)**, not density alone;
- name the GROMACS loop: `.gro` + `.top` + `.mdp` → `grompp` → `.tpr` → `mdrun`;
- change coexistence temperature with **`ref_t`** in the MDP;
- read ρ_liq and ρ_vap from a density profile ρ(z) and place them on a VLCC.

This is the same file-and-command habit used in later MSSE GROMACS sessions (interfaces, clay–fluid).

---

## How to start

If you cloned this school repository:

```bash
cd 02_Hands-On-Sessions/00_MD_Intro_GROMACS
```

Then follow [STUDENT_GUIDE.md](STUDENT_GUIDE.md). In short:

1. **Part 1** — Python: `cd part1_interactive_md` → `pip install -r requirements.txt` → open `LJ_coexistence_applet.ipynb`.
2. **Part 2** — confirm `gmx --version` (see [pre-course GROMACS install](../../00_Pre-Instructions/)). Work from `part2_gromacs/`. Long coexistence runs are already in `precomputed/` — do not wait for full productions in the room.

Requirements (Part 1): `numpy`, `matplotlib`, `ipywidgets`, `jupyter`.  
Part 2: a working GROMACS install.

---

## Contents

| Path | Role |
|------|------|
| [STUDENT_GUIDE.md](STUDENT_GUIDE.md) | Setup, folder map, citations |
| [part1_interactive_md/LJ_coexistence_applet.ipynb](part1_interactive_md/LJ_coexistence_applet.ipynb) | Interactive LJ applet + exercises |
| [part1_interactive_md/student_handout.md](part1_interactive_md/student_handout.md) | What the three panels mean |
| [part2_gromacs/LJ_coexistence_GROMACS.ipynb](part2_gromacs/LJ_coexistence_GROMACS.ipynb) | Methane slab, MDP, VLCC |
| [part2_gromacs/commands_cheatsheet.md](part2_gromacs/commands_cheatsheet.md) | `grompp` / `mdrun` / `gmx density` |
| `part2_gromacs/structures/`, `FF/`, `MDP/`, `inputs/` | Starting box, TraPPE-like CH₄, run controls |
| `part2_gromacs/precomputed/T_110` … `T_170` | Shipped production runs + `density_z.xvg` |


---

## Materials cited

- D. V. Schroeder, “Interactive molecular dynamics,” *Am. J. Phys.* **83**, 210–218 (2015). [doi:10.1119/1.4901185](https://doi.org/10.1119/1.4901185) — Part 1 is a teaching reimplementation, not a copy of that software.
- M. J. Abraham et al., “GROMACS…,” *SoftwareX* **1–2**, 19–25 (2015). [doi:10.1016/j.softx.2015.06.001](https://doi.org/10.1016/j.softx.2015.06.001)
- M. G. Martin and J. I. Siepmann, *J. Phys. Chem. B* **102**, 2569–2577 (1998). [doi:10.1021/jp972543+](https://doi.org/10.1021/jp972543+) — TraPPE-UA alkanes. Validation VLCC plots: [trappe.oit.umn.edu/validation](http://trappe.oit.umn.edu/validation/) (ethane is the next *n*-alkane).

Full list: [STUDENT_GUIDE.md](STUDENT_GUIDE.md).

---

## Further learning (Erastova group)

After the school, or if you want more GROMACS practice:

- Teaching page: https://www.erastova.xyz/teaching/  
- Group GitHub: https://github.com/Erastova-group  
- Open MD course materials (*Introduction to Computational Chemistry Techniques* taught at the School of Chemistry, University of Edinburgh):  
  https://github.com/Edinburgh-Chemistry-Teaching/MD_ResearchTechniques  
- Stewart et al., “Course Materials for an Introduction to Computational Chemistry Techniques,” *JOSE* **8**, 299 (2025). https://doi.org/10.21105/jose.00299  

Clay / rock–fluid tooling you will meet later in the school spirit: [ClayCode](https://github.com/Erastova-group/ClayCode) and related workshops on the group GitHub.

---

## Reuse

Intended for MSSE teaching. Copyright remains with the author unless a file states otherwise; see the school [rights and permissions](../../RIGHTS-AND-PERMISSIONS.md). Contact [valentina.erastova@ed.ac.uk](mailto:valentina.erastova@ed.ac.uk) before redistributing outside the school.
