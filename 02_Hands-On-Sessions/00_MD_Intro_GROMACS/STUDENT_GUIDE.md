# Student guide — Fundamentals of Molecular Simulations (GROMACS)

**Dr Valentina Erastova**, [valentina.erastova@ed.ac.uk](mailto:valentina.erastova@ed.ac.uk), University of Edinburgh  
September 2026

Read this **before** opening the notebooks. Setup and environment checks live here, not in the Jupyter files.

---

## What this session is

One physical problem, two tools:

| Part | Tool | What you do |
|------|------|-------------|
| **1** | Interactive LJ applet (Jupyter widgets) | Change sliders only. See gas / liquid / solid and interfaces; read g(r); break Δt on purpose. |
| **2** | GROMACS methane liquid–vapour slab | Same coexistence idea on CH₄ (UA). Edit `.mdp` (especially `ref_t`); inspect _precomputed_ density profiles. |

No coding in Part 1. Part 2 uses a terminal for `gmx` commands (copy from the notebook).

**Throughline:** liquid–vapour coexistence — Part 1 toy LJ → Part 2 methane (natural gas / hydrate-relevant) — then the same GROMACS knobs in later hands-on sessions.

---

## Folder map

```
MD_Intro_Gromacs/
├── STUDENT_GUIDE.md              ← you are here
├── part1_interactive_md/
│   ├── LJ_coexistence_applet.ipynb
│   ├── student_handout.md
│   ├── lj_applet.py
│   └── requirements.txt
├── part2_gromacs/
│   ├── LJ_coexistence_GROMACS.ipynb
│   ├── commands_cheatsheet.md
│   ├── structures/  FF/  MDP/  inputs/
│   └── precomputed/              ← T_110 … T_170 (shipped)
└── after_session/                ← shared after class (takeaways + answers)
```

Scratch folders `em/`, `nvt/`, `prod/`, `analysis/` appear under `part2_gromacs/` only if you run `gmx` yourself.

---

## Get started (do this once)

### 1. Open a terminal and go to the session folder

```bash
cd MD_Intro_Gromacs    # or the full path you were given
```

### 2. Part 1 — Python packages

```bash
cd part1_interactive_md
pip install -r requirements.txt
```

Packages: `numpy`, `matplotlib`, `ipywidgets`, `jupyter`.

### 3. Launch Jupyter Part 1

From `part1_interactive_md` (return with `cd ../part1_interactive_md` if needed):

```bash
jupyter notebook LJ_coexistence_applet.ipynb
```

Or open the folder in JupyterLab / VS Code and open the notebooks from there.


### 3. Part 2 — check GROMACS

```bash
gmx --version
```

You should see a GROMACS version banner. If `gmx: command not found`, fix the install / module / PATH with the instructors **before** Part 2.

Optional: confirm you can reach the Part 2 folder:

```bash
cd ../part2_gromacs
pwd
ls structures MDP FF inputs
```

### 4. Launch Jupyter Part 2

From `part2_gromacs`:

```bash
jupyter notebook LJ_coexistence_GROMACS.ipynb
```

---

## During the session

1. **Part 1** — [LJ_coexistence_applet.ipynb](part1_interactive_md/LJ_coexistence_applet.ipynb)  
   Keep [student_handout.md](part1_interactive_md/student_handout.md) nearby for what the panels mean.
2. **Part 2** — [LJ_coexistence_GROMACS.ipynb](part2_gromacs/LJ_coexistence_GROMACS.ipynb)  
   Work in a terminal from `part2_gromacs`. Use [commands_cheatsheet.md](part2_gromacs/commands_cheatsheet.md) if you get stuck.  
   Long runs are in `precomputed/` — do not wait for full coexistence production in the session.

---

## Materials cited in this session

**Interactive MD design (Part 1)**  
D. V. Schroeder, “Interactive molecular dynamics,” *Am. J. Phys.* **83**, 210–218 (2015).  
https://doi.org/10.1119/1.4901185  
Web app: https://physics.weber.edu/schroeder/md/InteractiveMD.html  

Our Jupyter applet is a **teaching reimplementation** inspired by Schroeder’s design (hard walls, LJ fluid, phase presets).

**GROMACS (Part 2)**  
M. J. Abraham et al., “GROMACS: High-performance molecular simulations through multi-level parallelism from laptops to supercomputers,” *SoftwareX* **1–2**, 19–25 (2015).  
https://doi.org/10.1016/j.softx.2015.06.001  
Manual / downloads: https://www.gromacs.org  

**United-atom methane / TraPPE (Part 2)**  
Our UA CH₄ parameters are **TraPPE-like** (one LJ site). Original alkane TraPPE-UA paper:  
M. G. Martin and J. I. Siepmann, “Transferable Potentials for Phase Equilibria. 1. United-Atom Description of *n*-Alkanes,” *J. Phys. Chem. B* **102**, 2569–2577 (1998).  
https://doi.org/10.1021/jp972543+  

Validation database (VLCC = vapour–liquid coexistence curve; critical properties):  
http://trappe.oit.umn.edu/validation/  
**Look at ethane there** — next *n*-alkane (**one carbon more** than methane). Same TraPPE-UA family and the same VLCC layout you plot for CH₄. Classroom \(T_c\) uses the scaling \(\Delta\rho\propto(T_c-T)^\beta\) with \(\beta\approx0.325\) (3D Ising; fixed, as in TraPPE-style fits).

---

## Further learning (Erastova group)

After the school, or if you want more GROMACS practice:

- Teaching page: https://www.erastova.xyz/teaching/  
- Group GitHub: https://github.com/Erastova-group  
- Open MD course materials (*Introduction to Computational Chemistry Techniques*):  
  https://github.com/Edinburgh-Chemistry-Teaching/MD_ResearchTechniques  
- Stewart et al., “Course Materials for an Introduction to Computational Chemistry Techniques,” *JOSE* **8**, 299 (2025). https://doi.org/10.21105/jose.00299  

Clay / rock–fluid tooling you will meet later in the school spirit: [ClayCode](https://github.com/Erastova-group/ClayCode) and related workshops on the group GitHub.

---

## If something breaks

| Symptom | Try |
|---------|-----|
| `ipywidgets` / blank applet | Re-run `pip install -r requirements.txt`; restart kernel; re-run import + `show_applet()` |
| Play stuck / frozen run | Kernel → Interrupt; re-run Part 1 cells |
| `gmx: command not found` | Ask instructors; do not skip the version check |
| `grompp` warnings | Read them; do not habitually add `-maxwarn` |
