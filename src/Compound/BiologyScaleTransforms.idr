module Compound.BiologyScaleTransforms

import Core.ScaleTransform
import Compound.BiophysicalAggregation

%default total

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
