# Idris2-Biology

[![Idris 2 Verification](https://img.shields.io/badge/Idris_2-0.8.0-blue.svg)](https://www.idris-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Layer 6 Hierarchical Biological Systems, Term Rewriting Systems & Active Inference for Idris 2**

`Idris2-Biology` forms **Layer 6** of the 10-layer constructive non-linear multiset science framework. It formalizes hierarchical matter ascent pipelines (`HierarchicalMatterPipeline`), biological scale transformations (`transformMoleculeToBiomodule`), Term Rewriting System (TRS) universal algebra confluence provers, active inference neural networks ($\Delta F \le 0$), Hodgkin-Huxley action potential kinetics, and Michaelis-Menten enzyme kinetics.

---

## 📦 Core Library Architecture & Modules

### 1. `Compound.HierarchicalMatterPipeline` & `Compound.BiologyScaleTransforms`
- **7-Phase Matter Ascent Pipeline:** `HierarchicalMatterPipeline` mapping lower-level biomolecules to functional cellular organelles and biomodules.
- **Scale Transform:** `transformMoleculeToBiomodule` scale transformation (`MoleculeToken -> BiomoduleToken`).

### 2. `Compound.UniversalAlgebraTRS`
- **Universal Algebra TRS:** Term Rewriting System (TRS) soundness provers, verifying algebraic confluence, termination, and Church-Rosser properties across hierarchical matter transformations.

### 3. `Compound.ActiveInferenceNeuralNetwork`
- **Active Inference & Variational Free Energy:** Active inference neural network models (`ActiveInferenceNeuralNetwork`) optimizing perception and action via discrete variational free energy minimization ($\Delta F \le 0$).

### 4. `Compound.BiophysicalAggregation`
- **Biophysical Self-Assembly:** Supramolecular self-assembly, membrane channel transport, and biophysical aggregation kinetics.

### 5. `Math.RibosomalTranslation`, `Math.ActionPotentialKinetics`, `Math.AllostericCooperativity`, `Math.EnzymeKinetics`
- **Ribosomal Translation:** Exact multiset mRNA codon translation to amino acid polypeptide chains.
- **Hodgkin-Huxley Kinetics:** Discrete action potential propagation over neuronal membrane ion channels.
- **MWC Allosteric Cooperativity:** Monod-Wyman-Changeux (MWC) protein conformational cooperativity.
- **Michaelis-Menten Kinetics:** Discrete enzyme-substrate kinetic state transitions ($E + S \rightleftharpoons ES \to E + P$).

---

## 🚀 Building & Installing

```bash
idris2 --build Idris2-Biology.ipkg
idris2 --install Idris2-Biology.ipkg
```

---

## 🔬 Architectural Principles

- **Total Constructivism:** Enforces `%default total` across all biological pipeline modules.
- **TRS Confluence & Soundness:** Compile-time proof of termination and confluence for biological rewrite rules.
- **Variational Free Energy Minimization:** Active inference bounds ($\Delta F \le 0$) governing cellular perception.
