<div align="center">

<br/>

```
 ██████╗███████╗██████╗      █████╗ ███╗   ██╗ █████╗ ██╗  ██╗   ██╗███████╗██╗███████╗
██╔════╝██╔════╝██╔══██╗    ██╔══██╗████╗  ██║██╔══██╗██║  ╚██╗ ██╔╝██╔════╝██║██╔════╝
██║     █████╗  ██║  ██║    ███████║██╔██╗ ██║███████║██║   ╚████╔╝ ███████╗██║███████╗
██║     ██╔══╝  ██║  ██║    ██╔══██║██║╚██╗██║██╔══██║██║    ╚██╔╝  ╚════██║██║╚════██║
╚██████╗██║     ██████╔╝    ██║  ██║██║ ╚████║██║  ██║███████╗██║   ███████║██║███████║
 ╚═════╝╚═╝     ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚══════╝╚═╝╚══════╝
```

### Ventricular Assist Device · Blood Flow Simulation · k-ω & k-ε Turbulence Models

<br/>

![Type](https://img.shields.io/badge/Type-Thesis%20Project-crimson?style=flat-square)
![Tool](https://img.shields.io/badge/CAD-SpaceClaim-blue?style=flat-square)
![CFD](https://img.shields.io/badge/Simulation-CFD%20Blood%20Flow-red?style=flat-square)
![Models](https://img.shields.io/badge/Turbulence-k--ω%20%7C%20k--ε-darkblue?style=flat-square)

</div>

---

<br/>

## `/ overview`

> A thesis-level CFD study of a **Ventricular Assist Device (VAD)** — modelled in SpaceClaim from research literature, then simulated for internal blood flow using two turbulence models. Design changes were applied and their effects on device performance were analysed.

The results were compared against the original reference design. Some improvements emerged, others declined — leaving an open, honest engineering conclusion.

<br/>

---

## `/ simulation preview`

<!-- 📸 Add CFD output image here (velocity field, pressure contour, etc.) -->

<div align="center">

```
[ IMAGE — CFD Output / Flow Visualisation ]
```

</div>

<br/>

---

## `/ methodology`

```
RESEARCH
  └── Study reference VAD design & performance targets
        │
        ▼
3D MODELLING  ──  SpaceClaim
  └── Reconstruct VAD geometry from literature
        │
        ▼
CFD SETUP
  └── Define blood flow properties & boundary conditions
        │
        ▼
SIMULATION  ──  Two turbulence models
  ├── k-omega  (k-ω)
  └── k-epsilon (k-ε)
        │
        ▼
RESULTS COMPARISON
  └── Outputs vs. reference device
        │
        ▼
DESIGN MODIFICATIONS  ──  Geometry changes
        │
        ▼
RE-SIMULATION & ANALYSIS
  └── Inconclusive — some metrics improved, some declined
```

<br/>

---

## `/ results summary`

| Metric | Original | Modified | Verdict |
|--------|----------|----------|---------|
| Flow Efficiency | Baseline | ↑ Improved | ✅ |
| Pressure Distribution | Baseline | ~ Mixed | ⚠️ |
| Shear Stress | Baseline | ↓ Declined | ❌ |
| Overall | — | — | **Inconclusive** |

> Design changes showed trade-offs. The modifications did not definitively improve or worsen the device — a real and valid engineering finding.

<br/>

---

## `/ tools`

```
Ansys SpaceClaim   ──  3D modelling of the VAD
CFD Solver         ──  Blood flow simulation
k-ω model          ──  Turbulence (near-wall sensitive)
k-ε model          ──  Turbulence (bulk flow)
Research Papers    ──  Reference geometry & performance data
```

<br/>

---

## `/ documentation`

> 📄 Fully documented — model, methodology, simulation setup, results, and analysis available in the project report.

<br/>

---

<div align="center">

*Thesis project — CFD analysis of a biomedical fluid system*  
*Honest engineering: not all changes improve everything.*

</div>
