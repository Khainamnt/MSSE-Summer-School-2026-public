# After the session — key takeaways

**Dr Valentina Erastova** · MSSE Day 1 · Fundamentals of Molecular Simulations (GROMACS)

You practised **one idea** — liquid–vapour coexistence / phases — first with a toy LJ fluid, then with **methane** in GROMACS.  
Here is what you should now be able to say out loud. Keep this sheet for the rest of the school.

---

## What you now know

### 1. MD needs a sensible timestep
- Positions advance with a finite **Δt** (`dt` in GROMACS).  
- Too large → particles jump into the repulsive core → forces explode → **blow-up** (nonsense T and P).  
- Safe Δt is set by the **potential / fastest motion**, not by impatience.  
- Do **not** “speed up” a run by breaking `dt`.

### 2. Phases: density vs structure
- **Density (ρ)** says *how much* stuff is there.  
- **g(r)** says *how it is ordered*:  
  - liquid → a few shells that **decay** toward 1  
  - solid → **sharp peaks** that persist  
  - gas → nearly flat after a short contact peak  
- Liquid and solid can both look “dense”; structure settles the argument.

### 3. Equilibration is not a pretty picture
Judge a run by steady **T** (near the setpoint), non-runaway **P**, stable **ρ**, and stable structure — not by one snapshot.  
Atom colour in the applet was **speed**, not chemistry.

### 4. Interfaces = two phases in one box
- Coexistence is where phases meet (droplet / slab).  
- A **box-average** density mixes both phases — weak.  
- Use a **density profile** ρ(z) to read **ρ_liq** (peak of the liquid band) and **ρ_vap** (outer plateaus).  
- Same *mindset* as reservoir interfaces; later: IFT and fluid–rock.

### 5. Force fields must be validated like engineering models
- The **force field** (and later **charges**) is trusted only after it matches **thermodynamics and structure** (phases, g(r), coexistence densities / VLCC).  
- One movie is a weak test.  
- Oil-engineer line: you trust an EOS after PVT; you trust a **force field** the same way.

### 6. GROMACS file loop (Part 2)

Same staged pipeline used throughout the school’s GROMACS sessions:

```text
.gro + .top + .mdp → grompp → .tpr → mdrun → outputs
```

Staged workflow: **EM → NVT → production → analysis**.

| File | Role |
|------|------|
| `.gro` | Coordinates + box |
| `.top` (+ `.itp`) | Topology / force field |
| `.mdp` | How to run (dt, T, thermostat, …) |
| `.tpr` | Compiled run input from `grompp` |
| `.cpt` | Checkpoint to continue a run |

- Coexistence temperature → **`ref_t`** in the MDP (**kelvin**).  
- Methane force field → **`FF/lj_methane.itp`** (TraPPE-like).  
- This slab used **NVT** (`pcoupl = no`) so liquid and vapour can coexist at fixed volume.  
- **VLCC** = vapour–liquid coexistence curve (ρ on $x$, T on $y$ in the TraPPE-style plot). Classroom $T_c$ from $\Delta\rho\propto(T_c-T)^\beta$ with $\beta\approx0.325$ (3D Ising). TraPPE methane ≈ **190 K**; a low classroom estimate is normal for this small slab.

### 7. Methane today ≠ hydrate cage
- UA methane = natural-gas molecule; hydrates are a geological *motivation*.  
- You simulated **bulk liquid–vapour coexistence**, not ice cages or rock.

---

## Ready for the rest of MSSE if you can answer

1. What three inputs does `grompp` need?  
2. Where do you set temperature for a coexistence point?  
3. Why compare simulated ρ_liq(T), ρ_vap(T) to experiment when validating a FF?  
4. What extra interaction appears in water/clay force fields (beyond LJ), and how is it validated in spirit?

*(Discussion answers: see `MODEL_ANSWERS.md` in this folder.)*

---

## Where this goes next

| Session | Same habits, harder chemistry |
|---------|-------------------------------|
| **Mehdi Ghasemi** | H₂–brine interfaces / IFT — same `grompp` / `mdrun` / MDP thinking |
| **Sarah Stewart** | Clay–fluid / ClayFF — same file loop on the rock side |

You already know the language: phases, interfaces, density profiles, validate before you trust the numbers.
