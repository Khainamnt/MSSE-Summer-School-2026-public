# After the session — discussion answers

**Dr Valentina Erastova** · MSSE Day 1  
Released **after** the hands-on so you can check your notes. Short answers that hit the same idea are fine.

---

## Part 1 — Timestep

### 1. What goes wrong when Δt is too large?
Particles jump too far in one step, often into the steep repulsive core of the LJ potential. Forces and velocities explode; T and P become nonsense; the run shows **SIMULATION BLEW UP**. The integrator is no longer following Newton’s equations faithfully.

### 2. What about the potential sets a safe timestep?
The **steepness of the repulsive wall** (and any fast motions). Δt must be small enough that forces barely change over one step. Impatience does not set Δt — the potential does. (Later: bonds / hydrogens force small `dt` in GROMACS, often ~1–2 fs with constraints.)

### 3. Why is increasing `dt` a bad way to “speed up” a GROMACS run?
You trade wall-clock time for **wrong physics**. Unstable or biased trajectories make thermodynamics and structure unreliable. Speed up with more cores, shorter *needed* sampling, or coarse-graining — not by breaking the integrator.

### 4. When it blows up, what happens to T and P?
Both typically **spike to huge / non-physical values** (atoms may look chaotically “hot” — bright = high speed). Broken thermodynamics, not just a messy picture.

---

## Part 1 — Phases + g(r)

### 1. How does g(r) distinguish liquid from solid when both look “dense”?
Density says *how much*; **g(r)** says *how ordered*:

| | Liquid | Solid |
|---|--------|--------|
| Atoms | Dense, disordered; particles diffuse | Dense lattice; vibrate in place |
| g(r) | A few shells that **decay** toward 1 | **Sharp peaks** that persist with r |

### 2. How do you know the system is equilibrated?
Not from one pretty frame. Look for T fluctuating around the setpoint (not exploding), P noisy but not runaway, stable ρ, and structure (g(r) / phase) that has stopped systematically changing.

### 3. Compare recorded ρ for gas vs liquid vs solid
**Gas** is lowest; **liquid** and **solid** are both high (dense packing).  
ρ alone does **not** decide liquid vs solid — use g(r) / order.

### 4. Is recorded P noisier than T? Why?
**Usually yes.** Wall pressure in a tiny system is jagged; kinetic T averages over many particles and is smoother. Same lesson as noisy pressure in `gmx energy` — trust trends/averages.

---

## Part 1 — Interfaces

- **Liquid + gas:** droplet + vapour; T* changes can grow/shrink the droplet.  
- **Solid + gas:** crystal + vapour; too high T* melts the crystal.  
- **Solid + liquid:** ordered next to disordered; raising T* can melt the solid.

**Box-average ρ for liquid+gas** sits **between** liquid and gas because one number averages both phases. That is why Part 2 uses a **density profile** ρ(z) to read ρ_liq and ρ_vap separately.

Interfaces are where two phases meet — same *mindset* as reservoir phase behaviour and (later) IFT / fluid–rock slabs. This toy had hard walls and no rock.

---

## Part 1 — Validating a force field

### 1. Which observables could test whether this LJ model is “right”?
Phase identity, **g(r)**, stable T/P behaviour, and densities (including later ρ_liq / ρ_vap on a coexistence curve). Pretty movies are not a validation metric.

### 2. How would validation work for Coulomb / partial charges?
Same loop: choose parameters → predict measurable properties (densities, structure, phase behaviour, IFT, adsorption, …) → compare to experiment or higher-level theory → accept, reject, or refine. Charged molecular models (water, brine, clay) use the same *spirit*.

### 3. Why is one snapshot a weak test?
A single frame can look right by chance. **Phases, g(r), and coexistence densities** are reproducible targets.

**Oil-engineer sentence:** you trust an EOS after it matches PVT; you trust a **force field** after it matches the right experiments — not after one picture looks oily.

---

## Part 2 — Methane slab (GROMACS)

### 1. Which single MDP line selects the coexistence point on the curve?
**`ref_t`** (temperature in **Kelvin**). That chooses the state point; ρ_liq and ρ_vap come from the equilibrated slab.

### 2. What would happen if you turned on an isotropic barostat on this slab?
It can **destroy the interface** or force a single phase. Orthobaric liquid–vapour coexistence in this teaching setup needs **fixed volume (NVT)** — `pcoupl = no`. (Anisotropic / IFT setups come later in the school.)

### 3. Where does the methane force field live — and how did Part 1 show interaction parameters affect phases?
In **`FF/lj_methane.itp`** (united-atom CH₄). Part 1: with a fixed LJ model, changing T* and packing changes gas / liquid / solid. Same idea: the methane force field controls the coexistence densities at each `ref_t`.

### 4. Why is a coexistence curve a validation observable? How does Coulomb fit in later?
ρ_liq(T) and ρ_vap(T) are sensitive to the interaction parameters — comparing the envelope to experiment tests the model (Sofia’s loop).  
UA methane here has **q = 0**. Water, brine, and ClayFF add **Coulomb**. Validation *spirit* unchanged: predict → compare → accept/reject.

### 5. Classroom $T_c$ vs TraPPE ≈ 190 K — why are *we* low?

Use $\Delta\rho=\rho_\mathrm{liq}-\rho_\mathrm{vap}\propto(T_c-T)^\beta$ with $\beta\approx0.325$ (3D Ising exponent; fixed in TraPPE-style $T_c$ fits, not fitted here): linearise $[\Delta\rho]^{1/\beta}$ vs $T$ → $T_c$; rectilinear diameter → $\rho_c$.

Example peaks/plateaus give a classroom $T_c$ **around 160 K**. That is **not** TraPPE being cold: TraPPE-UA methane is **≈ 190 K** and proper TraPPE validation (Gibbs ensemble, large systems, state points near $T_c$) is typically **on target or slightly high** vs experiment.

Our underestimate is the **protocol**: small NVT slab, short production, only 110–140 K (far from criticality), finite-size loss of the liquid film. Compare the vapour–liquid coexistence curve (VLCC) *shape* to TraPPE ethane on the validation site (one C more) — do not expect our live extrapolation to hit 190 K.

### 6. Geological hook (methane / hydrates)
Methane is the fluid in natural gas and in **methane hydrate** (“combustible ice”) research. This session only did **bulk liquid–vapour coexistence**, not a hydrate lattice. The transferable skill is the GROMACS file loop + reading interfaces/densities.

---

## Exit checklist (“ready for tomorrow”)

### 1. What three inputs does `grompp` need?
**Coordinates** (`.gro`), **topology** (`.top`, which pulls in FF `.itp` files), and **MDP** (`.mdp`). Output: `.tpr` for `mdrun`.

### 2. Where do you set temperature for a coexistence point?
In the **`.mdp`**: **`ref_t`** (and `gen_temp` if you generate velocities at the start of NVT).

### 3. Why compare simulated ρ_liq(T), ρ_vap(T) to experiment when validating a FF?
Coexistence densities are a clear thermodynamic test of the parameters. If the curve is wrong, the model is not predictive for phase behaviour — even if a movie looks fine.

### 4. What extra interaction appears in water/clay FFs, and how is it validated in spirit?
**Coulomb** (partial charges), on top of LJ. Validated the same way: against structure, thermodynamics, and application properties (IFT, adsorption, layering) — not against a single snapshot.

---

## One-line summary

Large Δt breaks physics · g(r) tells liquid from solid · validate FF with thermo/structure · `grompp` needs `.gro` + `.top` + `.mdp` · coexistence T is `ref_t`.
