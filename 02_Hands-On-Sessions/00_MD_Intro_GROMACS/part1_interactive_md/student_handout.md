# Part 1 — What you are doing and seeing

You are running a tiny **2D molecular dynamics** simulation: particles feel a Lennard-Jones force and bounce off **hard walls** (not periodic boundaries). You only change widgets — no coding.

**Atom colours:** colour = **speed**, not atom type (darker ≈ slower, brighter/yellow ≈ faster).

**Acknowledgement.** Design inspired by Daniel V. Schroeder’s [Interactive Molecular Dynamics](https://physics.weber.edu/schroeder/md/InteractiveMD.html). This notebook version is a teaching reimplementation for the school, not a copy of that software.

> D. V. Schroeder, “Interactive molecular dynamics,” *Am. J. Phys.* **83**, 210–218 (2015).  
> https://doi.org/10.1119/1.4901185

## The three panels

1. **Atoms** — disks in a square box with walls. Phase should be obvious by eye once you pick a preset. Colour = speed.  
2. **T and P vs time** — kinetic temperature and wall pressure. They fluctuate; they should not explode.  
3. **g(r)** — radial distribution. Sharp lasting peaks → solid; a few decaying shells → liquid; nearly flat after the first contact peak → gas.

**Status / Record:** number density **ρ = N/L²**, **T**, **P**, and max **g(r)**. Press **Record T, P, ρ, g(r)** when a run looks steady.

## Presets (start here)

| Preset | What you should see |
|--------|---------------------|
| **Gas** | Sparse; fills the box |
| **Liquid** | Dense, disordered; fills the box |
| **Solid** | Hexagonal crystal; vibrate in place |
| **Liquid + gas** | Droplet + vapour |
| **Solid + gas** | Crystal clump + vapour |
| **Solid + liquid** | Hex crystal (left) next to looser disordered fluid (right); keep T* low or the crystal melts |

## Exercises (with the room)

### 1. Timestep — break it on purpose
- Preset **Liquid**, Δt ≈ **0.015**, run briefly (stable).  
- Raise Δt to **~0.08–0.12**, run → **SIMULATION BLEW UP**.  
- **Reset**, put Δt back down.

**Discuss:** What failed? What happens to T and P? Why can’t we “just use a huge timestep”? (Same idea as `dt` in GROMACS.)

### 2. Phases + g(r) + density
Cycle **Gas / Liquid / Solid**. For each: Reset → run → **Record**.  
**Discuss:** How does g(r) distinguish liquid from solid when both look “dense”? Which recorded **ρ** is highest? Why is **P** noisier than **T**?

### 3. Interfaces
Try **Liquid + gas** and **Solid + liquid**. Change T* a little, Reset, run.  
**Record** when steady. For liquid+gas: is box-average **ρ** a fair single number for a two-phase system?

### 4. Force-field validation (link to Sofia)
The LJ model is judged by whether structure/thermodynamics look right (phases, g(r), T/P/ρ behaviour) — not by one pretty snapshot. Molecular force fields add charges; same *spirit* of validation later in the school.

## After this
Same ideas in **GROMACS**: T and Δt in the `.mdp`; methane force field in `FF/lj_methane.itp`; structure and density profiles from the trajectory.
