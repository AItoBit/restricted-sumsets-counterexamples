module
public import Mathlib.Data.ZMod.Basic
public import Mathlib.Data.Finset.Card

public section
namespace RestrictedSumsetsAudit

/-- Sums of one element from each set, excluding equal summands. -/
def restrictedSumset {p : ℕ} (s t : Finset (ZMod p)) : Finset (ZMod p) :=
  ((s.product t).filter (fun ab => ab.1 ≠ ab.2)).image (fun ab => ab.1 + ab.2)
/-- The first n terms of a cyclic arithmetic progression starting at a with difference d. -/
def progression {p : ℕ} (n : ℕ) (a d : ZMod p) : Finset (ZMod p) :=
  (Finset.range n).image (fun (i : ℕ) => a + (i : ZMod p) * d)
/-- The seven-element witness in Z/13Z. -/
def A : Finset (ZMod 13) := {0, 1, 3, 4, 5, 6, 10}
/-- The four-element witness in Z/13Z. -/
def B : Finset (ZMod 13) := {0, 1, 4, 6}

/-- Counterexample to Theorem A / Theorem 3.1 of arXiv:2609.10148v2. -/
theorem counterexample_main :
    Nat.Prime 13 ∧ A.Nonempty ∧ B.Nonempty ∧
    A.card = 7 ∧ B.card = 4 ∧
    3 ≤ B.card ∧ B.card + 3 ≤ A.card ∧ A.card + B.card ≤ 13 - 1 ∧
    (restrictedSumset A B).card = A.card + B.card - 2 ∧
    restrictedSumset A B = {1, 3, 4, 5, 6, 7, 9, 10, 11} ∧
    (∀ a d : ZMod 13, A ≠ progression 7 a d) ∧
    (∀ a d : ZMod 13, B ≠ progression 4 a d) := by
  decide +kernel

/-- Independently, Lemma 3.2 is false with k=3 and l₀=4. -/
theorem counterexample_lemma :
    let s : Finset (ZMod 11) := {0, 1, 3}
    let t : Finset (ZMod 11) := {0, 1, 2, 3}
    Nat.Prime 11 ∧ s.card = 3 ∧ t.card = 4 ∧
    t = (Finset.range 4).image (fun (i : ℕ) => (i : ZMod 11)) ∧
    3 + 4 - 1 ≤ 11 - 1 ∧
    (∀ a d : ZMod 11, s ≠ progression 3 a d) ∧
    restrictedSumset s t = {1, 2, 3, 4, 5} ∧
    (restrictedSumset s t).card < s.card + t.card - 1 := by
  decide +kernel

end RestrictedSumsetsAudit

