# 🧫 Idris2-Biology

**Layer 5b Biological Systems, Kinetics, Allostery & Active Inference Neural Networks for Idris 2**

`Idris2-Biology` models biological emergence within the **Constructive Multiset Framework**. It lifts molecular chemistry into dynamic cellular kinetics, energetic translation, membrane action potentials, and active inference neural networks governed by free energy minimization.

---

## Key Modules & Specifications

| Module | Architectural Role & Domain Scope |
| :--- | :--- |
| **`Math.EnzymeKinetics`** | Discrete Michaelis-Menten kinetics ($K_m, V_{\max}$) over exact `UnixelFraction` rates. |
| **`Math.ActionPotentialKinetics`** | Hodgkin-Huxley membrane action potentials, voltage-gated ion channels, and discrete conductance. |
| **`Math.AllostericCooperativity`** | Monod-Wyman-Changeux (MWC) allosteric transitions, cooperative binding, and Hill coefficient $n_H$. |
| **`Math.RibosomalTranslation`** | Triplet codon translation, tRNA anticodon pairing, and QTT-linear peptide bond synthesis. |
| **`Compound.BiophysicalAggregation`** | Supramolecular macromolecular assembly and cellular organelle aggregation. |
| **`Compound.HierarchicalMatterPipeline`** | Multi-scale matter emergence pipeline ($T_{\text{total}} = T_4 \circ T_3 \circ T_2 \circ T_1$). |
| **`Compound.UniversalAlgebraTRS`** | Universal term rewriting system (TRS) for multiset algebraic transformations. |
| **`Compound.ActiveInferenceNeuralNetwork`** | Active inference neural networks minimizing discrete Helmholtz free energy ($F = U - TS$). |

---

## Dependencies

- **`Idris2-Multiset-Core`**
- **`Idris2-Multiset-Transform`**
- **`Idris2-Geometry`**
- **`Idris2-Physics`**
- **`Idris2-Hadron`**
- **`Idris2-Chemistry`**

---

## Building & Usage

Build the package using `idris2`:

```bash
idris2 --build Idris2-Biology.ipkg
idris2 --install Idris2-Biology.ipkg
```

---

&copy; Justin Kelly. Formalized in pair-programming collaboration with Google Antigravity.
