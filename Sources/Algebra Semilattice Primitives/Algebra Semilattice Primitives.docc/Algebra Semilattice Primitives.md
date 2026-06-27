# ``Algebra_Semilattice_Primitives``

Bounded join-semilattice witnesses — the algebraic foundation of state-based CRDT merge.

## Overview

A bounded semilattice (S, ∨, ⊥) is an associative + commutative + idempotent
binary operation `∨` together with an identity element `⊥`. The operation
induces a partial order `a ≤ b ⟺ a ∨ b = b`, and `⊥` is the bottom of that
order — the least upper bound of the empty set.

Bounded semilattices are the algebraic foundation for **state-based CRDTs
(CvRDTs)** per Shapiro et al. (*Conflict-Free Replicated Data Types*, SSS
2011): the merge operation of any convergent replicated data type is a
join-semilattice operation, and Strong Eventual Consistency (SEC) follows
from the semilattice laws.

This package ships ``Algebra/Semilattice`` as a witness struct over an
`Algebra.Monoid.Commutative<Element>` plus the documented idempotency
invariant. Idempotency, commutativity, and identity are documented
contracts — not enforced at compile time.

## Topics

### Capability witness

- ``Algebra/Semilattice``

### Stdlib conformances

- ``Algebra/Semilattice/disjunction``
- ``Algebra/Semilattice/conjunction``
- ``Algebra/Semilattice/maximum(bottom:)``
- ``Algebra/Semilattice/minimum(top:)``
