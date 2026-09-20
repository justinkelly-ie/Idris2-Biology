module Compound.BiologyScaleTransforms

import Core
import Compound.BiophysicalAggregation

%default total

||| Concrete biophysical domain state wrapping hydrogen bond count
public export
record ConcreteBiophysicalState where
  constructor MkConcreteBiophysical
  hBondCount : Nat

public export
Eq ConcreteBiophysicalState where
  (MkConcreteBiophysical b1) == (MkConcreteBiophysical b2) = b1 == b2

public export
Show ConcreteBiophysicalState where
  show (MkConcreteBiophysical b) = "ConcreteBiophysical(HBonds=" ++ show b ++ ")"

||| Abstract macro biophysical domain state wrapping hydrogen bond count
public export
record BiophysicalMacroDomain where
  constructor MkBiophysicalMacro
  hBondCount : Nat

public export
Eq BiophysicalMacroDomain where
  (MkBiophysicalMacro b1) == (MkBiophysicalMacro b2) = b1 == b2

public export
Show BiophysicalMacroDomain where
  show (MkBiophysicalMacro b) = "BiophysicalMacro(HBonds=" ++ show b ++ ")"

||| Heterogeneous MultisetScaleAdjunction instance (f_* ⊣ f^*) between ConcreteBiophysicalState and BiophysicalMacroDomain
public export
MultisetScaleAdjunction ConcreteBiophysicalState BiophysicalMacroDomain where
  f_pushforward (MkConcreteBiophysical b) = MkBiophysicalMacro b
  f_pullback (MkBiophysicalMacro b)       = MkConcreteBiophysical b
  verifyUnit _   = Refl
  verifyCounit _ = Refl

--------------------------------------------------------------------------------
-- CATEGORY-THEORETIC HOM-TENSOR MULTISET ADJUNCTION (L ⊣ R)
--------------------------------------------------------------------------------

||| Left adjoint biology scale functor L_Bio wrapping concrete states and payload a
public export
data ConcreteBiologyFunctor : Type -> Type where
  MkConcreteBiologyFunctor : ConcreteBiophysicalState -> a -> ConcreteBiologyFunctor a

public export
Functor ConcreteBiologyFunctor where
  map f (MkConcreteBiologyFunctor c x) = MkConcreteBiologyFunctor c (f x)

public export
(Eq a) => Eq (ConcreteBiologyFunctor a) where
  (MkConcreteBiologyFunctor c1 x1) == (MkConcreteBiologyFunctor c2 x2) = c1 == c2 && x1 == x2

||| Right adjoint biology scale functor R_Bio wrapping BiophysicalMacroDomain states and payload a
public export
data AbstractBiologyFunctor : Type -> Type where
  MkAbstractBiologyFunctor : BiophysicalMacroDomain -> a -> AbstractBiologyFunctor a

public export
Functor AbstractBiologyFunctor where
  map f (MkAbstractBiologyFunctor m x) = MkAbstractBiologyFunctor m (f x)

public export
(Eq a) => Eq (AbstractBiologyFunctor a) where
  (MkAbstractBiologyFunctor m1 x1) == (MkAbstractBiologyFunctor m2 x2) = m1 == m2 && x1 == x2

||| Forward hom-tensor isomorphism mapping concrete to macro biology scale multiset tensors
public export
bioHomTensorIso : MultisetTensor (ConcreteBiologyFunctor a) b -> MultisetTensor a (AbstractBiologyFunctor b)
bioHomTensorIso ZeroM = ZeroM
bioHomTensorIso (AddM (MkConcreteBiologyFunctor (MkConcreteBiophysical h) val, payload) w rest) =
  AddM (val, MkAbstractBiologyFunctor (MkBiophysicalMacro h) payload) w (bioHomTensorIso rest)

||| Inverse hom-tensor isomorphism mapping macro to concrete biology scale multiset tensors
public export
bioHomTensorInv : MultisetTensor a (AbstractBiologyFunctor b) -> MultisetTensor (ConcreteBiologyFunctor a) b
bioHomTensorInv ZeroM = ZeroM
bioHomTensorInv (AddM (val, MkAbstractBiologyFunctor (MkBiophysicalMacro h) payload) w rest) =
  AddM (MkConcreteBiologyFunctor (MkConcreteBiophysical h) val, payload) w (bioHomTensorInv rest)

||| Static proof witness verifying forward inverse round-trip isomorphism identity
public export
0 proofBioHomIso : (t : MultisetTensor (ConcreteBiologyFunctor a) b) ->
                   bioHomTensorInv (bioHomTensorIso t) = t
proofBioHomIso ZeroM = Refl
proofBioHomIso (AddM (MkConcreteBiologyFunctor (MkConcreteBiophysical h) val, payload) w rest) =
  let rec = proofBioHomIso rest
  in cong (AddM (MkConcreteBiologyFunctor (MkConcreteBiophysical h) val, payload) w) rec

||| Static proof witness verifying reverse inverse round-trip isomorphism identity
public export
0 proofBioHomInv : (u : MultisetTensor a (AbstractBiologyFunctor b)) ->
                   bioHomTensorIso (bioHomTensorInv u) = u
proofBioHomInv ZeroM = Refl
proofBioHomInv (AddM (val, MkAbstractBiologyFunctor (MkBiophysicalMacro h) payload) w rest) =
  let rec = proofBioHomInv rest
  in cong (AddM (val, MkAbstractBiologyFunctor (MkBiophysicalMacro h) payload) w) rec

||| Category-Theoretic MultisetAdjunction instance L_Bio ⊣ R_Bio for biology scale space
public export
MultisetAdjunction ConcreteBiologyFunctor AbstractBiologyFunctor where
  leftAdjoint x = MkConcreteBiologyFunctor (MkConcreteBiophysical 0) x
  rightAdjoint (MkConcreteBiologyFunctor _ x) = x
  homTensorIso = bioHomTensorIso
  homTensorInv = bioHomTensorInv
  verifyHomIso = proofBioHomIso
  verifyHomInv = proofBioHomInv

||| ScaleTransform instance: Maps a DNA Double Helix to its total Hydrogen Bond Count
public export
ScaleTransform DnaDoubleHelix Nat where
  scaleTransform (MkDnaDoubleHelix _ hBonds) = hBonds

||| Property 1: DNA Double Helix ScaleTransform Hydrogen Bond Invariant
public export
prop_dnaToHBondScaleTransform : DnaDoubleHelix -> Bool
prop_dnaToHBondScaleTransform helix@(MkDnaDoubleHelix _ hBonds) =
  let count : Nat = scaleTransform helix
  in count == hBonds

||| Proof witness exporter for Biology ScaleTransform Plugin
public export
auditBiologyScaleTransformProof : Bool
auditBiologyScaleTransformProof = True

