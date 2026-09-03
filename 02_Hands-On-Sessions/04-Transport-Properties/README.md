# 04 — Transport Properties

Hands-on session for the **MSSE Summer School 2026** on calculating molecular transport properties using **GROMACS** and **MDAnalysis**.

## Overview

This session focuses on molecular diffusion in bulk and confined systems, with applications relevant to subsurface engineering and underground gas storage.

The workflow progresses from simple self-diffusion calculations to more advanced confined and multicomponent transport analysis.

## Learning objectives

By the end of this session, participants should be able to:

- prepare molecular simulation systems for diffusion calculations;
- understand the difference between self-diffusion, Maxwell–Stefan diffusion, and Fick diffusion;
- calculate self-diffusion coefficients from mean squared displacement (MSD);
- identify ballistic, transitional, subdiffusive, and normal-diffusion regimes;
- select an appropriate MSD fitting interval;
- assess simulation convergence and statistical uncertainty;
- understand the importance of force-field combination validation;
- analyse the influence of salinity and molecular interactions on diffusion;
- calculate radial distribution functions (RDFs);
- analyse anisotropic diffusion under confinement;
- calculate molecular density profiles and residence/survival probabilities;
- use MDAnalysis for trajectory analysis;
- introduce collective transport and Maxwell–Stefan diffusion.

## Hands-on examples

### 1. CO₂ self-diffusion in bulk water

The first example introduces the complete molecular dynamics workflow:

- system construction;
- force-field and topology setup;
- energy minimisation;
- NPT equilibration;
- NVT equilibration;
- NVE production;
- mean squared displacement;
- calculation of the CO₂ self-diffusion coefficient;
- identification of the normal-diffusion regime;
- fitting-window sensitivity;
- trajectory sampling and convergence;
- finite-size effects;
- comparison between GROMACS and MDAnalysis analysis.

### 2. H₂ self-diffusion in brine

The second example introduces a multicomponent aqueous system containing H₂, water, Na⁺, and Cl⁻.

Topics include:

- construction of saline systems;
- calculation of salt concentration;
- H₂, water, and ion self-diffusion;
- effect of salinity on molecular mobility;
- radial distribution functions;
- interpretation of local solvation structure.

### 3. H₂ diffusion in a clay slit pore

The third example introduces diffusion under confinement.

A pre-built clay/water/H₂ system is used to study:

- molecular density profiles across the pore;
- anisotropic diffusion;
- diffusion parallel to the mineral surface;
- transverse molecular motion;
- molecular centre-of-mass trajectories;
- near-surface and pore-centre populations;
- residence and survival probabilities.

### 4. Collective diffusion in a bulk H₂–CO₂ mixture

The final example moves beyond tagged-particle self-diffusion and introduces collective transport.

Topics include:

- molecular centre-of-mass trajectories;
- collective species displacements;
- cross-correlations between species;
- Onsager transport coefficients;
- Maxwell–Stefan diffusion;
- distinction between Maxwell–Stefan and Fick diffusivities.

## Recommended simulation workflow

For equilibrium diffusion calculations, the general workflow used in this session is:

```text
Initial structure
       ↓
Energy minimisation
       ↓
NPT equilibration
Target temperature and pressure
       ↓
NVT equilibration
Target temperature and equilibrated density
       ↓
NVE production
Trajectory for transport analysis
       ↓
MSD / RDF / density / collective transport analysis
