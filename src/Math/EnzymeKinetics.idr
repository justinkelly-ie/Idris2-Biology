module Math.EnzymeKinetics

import Core.BoxInt
import Core.UnixelFraction
import Data.List
import Data.Fin
import Data.Vect

%default total

------------------------------------------------------------------------
-- 1. LAW 37: DISCRETE MICHAELIS-MENTEN ENZYME KINETICS
------------------------------------------------------------------------

||| Discrete Enzyme State:
|||   freeEnzyme    : [E] tokens
|||   enzymeComplex : [ES] tokens
|||   substrate     : [S] tokens
|||   product       : [P] tokens
public export
record EnzymeSystem where
  constructor MkEnzymeSystem
  freeEnzyme    : BoxInt
  enzymeComplex : BoxInt
  substrate     : BoxInt
  product       : BoxInt
  totalEnzyme   : BoxInt

public export
Eq EnzymeSystem where
  (MkEnzymeSystem e1 es1 s1 p1 t1) == (MkEnzymeSystem e2 es2 s2 p2 t2) =
    e1 == e2 && es1 == es2 && s1 == s2 && p1 == p2 && t1 == t2

||| Discrete Reaction Velocity Rate:
|||   v = (V_max * [S]) / (K_m + [S])
public export
computeReactionVelocity : (vMax : BoxInt) -> (km : BoxInt) -> (substrateConc : BoxInt) -> BoxInt
computeReactionVelocity vMax km s =
  let num = vMax * s
      den = km + s
  in if den == intToBoxInt 0 then intToBoxInt 0 else num `div` den

------------------------------------------------------------------------
-- 2. DISCRETE CATALYTIC TURNOVER STEP
-- [E] + [S] <-> [ES] -> [E] + [P]
------------------------------------------------------------------------

public export
stepCatalysis : EnzymeSystem -> (km : BoxInt) -> (kcat : BoxInt) -> EnzymeSystem
stepCatalysis (MkEnzymeSystem e es s p e0) km kcat =
  let -- Formation of enzyme-substrate complex
      bindAmount = if s > intToBoxInt 0 && e > intToBoxInt 0 then intToBoxInt 1 else intToBoxInt 0
      e' = e - bindAmount
      es' = es + bindAmount
      s' = s - bindAmount
      
      -- Catalytic conversion to product
      prodAmount = if es' >= intToBoxInt 1 then intToBoxInt 1 else intToBoxInt 0
      es'' = es' - prodAmount
      e'' = e' + prodAmount
      p' = p + prodAmount
  in MkEnzymeSystem e'' es'' s' p' e0

------------------------------------------------------------------------
-- 3. FORMAL INVARIANT AUDIT
------------------------------------------------------------------------

||| Audits Law 37 (Discrete Michaelis-Menten Enzyme Kinetics):
||| 1. Initial State: Free Enzyme E=10, ES=0, Substrate S=50, Product P=0, Total Enzyme E0=10.
||| 2. Hyperbolic Velocity: V_max = 100, K_m = 25, S = 50 -> v = (100 * 50) / (25 + 50) = 5000 / 75 = 66 tokens.
||| 3. Stepping catalysis maintains exact enzyme conservation: [E] + [ES] == [E]_0 = 10.
||| 4. Total substrate + product + complex tokens conserved: S + P + ES = 50.
public export
auditEnzymeKineticsProof : Bool
auditEnzymeKineticsProof =
  let initSys = MkEnzymeSystem (intToBoxInt 10) (intToBoxInt 0) (intToBoxInt 50) (intToBoxInt 0) (intToBoxInt 10)
      v = computeReactionVelocity (intToBoxInt 100) (intToBoxInt 25) (intToBoxInt 50)
      stepped = stepCatalysis initSys (intToBoxInt 25) (intToBoxInt 2)
      
      tVel = v == intToBoxInt 66
      tEnzymeConserv = freeEnzyme stepped + enzymeComplex stepped == totalEnzyme stepped
      tMassConserv = substrate stepped + product stepped + enzymeComplex stepped == intToBoxInt 50
  in tVel && tEnzymeConserv && tMassConserv
