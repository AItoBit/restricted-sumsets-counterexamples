# Restricted-sumset counterexamples

Lean 4 certificates refuting Theorem A / Theorem 3.1 and Lemma 3.2 **as stated in v2** of [Li and Liang, arXiv:2609.10148v2](https://arxiv.org/abs/2609.10148v2), revised 11 September 2026.

This repository contains counterexamples, not a formalization proving the paper. It makes no priority claim and does not assess the paper's boundary families or any subsequent revision. The paper authors have not been contacted and have not endorsed this work.

## Main certificate

In Z/13Z, let A = {0,1,3,4,5,6,10} and B = {0,1,4,6}.
Their restricted sumset (sums a+b with a != b) is {1,3,4,5,6,7,9,10,11}.
Thus |B|=4>=3, |A|=7>=|B|+3, |A|+|B|=11<=12, and the sumset has
9=|A|+|B|-2 elements. Neither A nor B is an arithmetic progression.
This contradicts the forward direction of Theorem A / Theorem 3.1, whose conclusion requires both to be progressions with a shared difference and B an endpoint segment of A.

`RestrictedSumsetsAudit.counterexample_main` checks every numerical hypothesis, the exact sumset, and non-progression for both sets. Excluding B alone already refutes the conclusion.

## Lemma certificate

In Z/11Z, take s={0,1,3} and t={0,1,2,3}=[0,3]. The restricted sumset is
{1,2,3,4,5}, of size 5, although Lemma 3.2 requires at least 3+4-1=6.
Here k=3, l0=4>=3, k+l0-1=6<=10, and s is not a progression.
The increasing representatives are 0<1<3<11. The lemma has no k>=l0 hypothesis;
adding one could remove this particular example but does not repair the separate
main-theorem counterexample.

`RestrictedSumsetsAudit.counterexample_lemma` records this certificate.

## Fidelity and proof method

The four compared definitions are `restrictedSumset`, `progression`, `A`, and `B`, all in namespace `RestrictedSumsetsAudit`.
The sumset is the image of a filtered Cartesian product, so equal summands are excluded before taking the image and repetitions count only once. `progression n a d` is the set {a+i*d : 0<=i<n} in Z/pZ. All starts and differences are tested, including zero difference; this is stronger than excluding only nonzero differences. For a set of cardinality n this covers every n-term arithmetic progression, including wraparound.

The certificates use ordinary `decide +kernel`: Lean's kernel reduces the finite propositions. Python enumeration aided discovery but is not trusted evidence or an input to the proof. The axiom audit reports only propext, Classical.choice, and Quot.sound. There is no sorry, custom axiom, or native_decide in the solution. The two intentional Challenge holes are statement placeholders for Comparator only.

The certificates are explicit witnesses, rather than literal negations of separately encoded universal paper theorems. Their contradiction with those statements follows from the clause-by-clause correspondence above. This is relevant to researchers in additive combinatorics studying inverse problems for restricted sumsets: it rules out the proposed non-boundary classification with its stated hypotheses.

## Provenance and verification

Maintainer: alexander. MIT license applies to this original formalization; the source paper is cited, not redistributed. AI assistance performed the search, Lean construction, independent statement audit, and packaging. No human expert review or mathematical priority is claimed.

Lean: 4.35.0-rc2. Mathlib: 065356127b1dc0016f66b7283ce0ce2c4055aa55.

```sh
lake exe cache get
lake build
lake env lean CheckAxioms.lean
```

`Challenge.lean` independently states the same definitions and two theorems using only Mathlib imports. `Solution.lean` imports the substantive proofs in `Counterexample.lean`. `comparator.json` selects both certificates and all four definitions. The manually dispatched `Palomar mechanical preflight` workflow runs Palomar's full pinned verification pipeline. A passing workflow is not editorial approval or registration.
