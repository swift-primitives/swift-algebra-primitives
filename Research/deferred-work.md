# Deferred Work

<!--
---
version: 1.0.0
last_updated: 2026-02-03
status: DEFERRED
---
-->

## Context

During the algebra-primitives correctness round (2026-01–02), we redesigned the algebraic witness hierarchy: Field gained typed throws, `Algebra.Field.Unit` was introduced for the multiplicative group of units, Ring projections were added, and CaseSet was deleted. The implementation converged across multiple rounds of research and planning.

This document records all work that was explicitly identified during that process but intentionally excluded from the current patch set. Every item below is additive, non-breaking, and can be introduced incrementally without revisiting the Field design.

## Question

What future work was identified but deferred during the algebra-primitives correctness round, and what are the dependency relationships between these items?

## Analysis

### 1. `Algebra.Z.Modulo<let n: Int>`

**Status**: Design locked, implementation deferred.

Canonical modular integer carrier parameterized by modulus. Always provides:

- Additive abelian group (mod n)
- Multiplicative commutative monoid (mod n)
- Commutative ring

Field availability is conditional on primality:

```swift
extension Algebra.Z.Modulo {
    static func field() -> Algebra.Field<Self>?
    // Returns nil when n is not prime.
}
```

Integrates with the existing typed-throwing `reciprocal` and `Field.Unit` group of units.

**Reason deferred**: Large addition. Not required for current correctness fixes.

**Dependencies**: None (self-contained). Enables items 2, 4, and 6.

---

### 2. Z₂ Witness Consolidation via Isomorphism

**Status**: Deferred (non-critical ergonomics).

Five semantic 2-case carriers currently duplicate identical XOR-style group definitions:

| Carrier | Identity | File |
|---------|----------|------|
| `Parity` | `.even` | `Algebra.Group+Parity.swift` |
| `Bound` | `.lower` | `Algebra.Group+Bound.swift` |
| `Boundary` | `.closed` | `Algebra.Group+Boundary.swift` |
| `Endpoint` | `.start` | `Algebra.Group+Endpoint.swift` |
| `Gradient` | `.ascending` | `Algebra.Group+Gradient.swift` |

All five use the same combining logic: `lhs == rhs ? .identity : .other`. The semantic carriers should be kept (they carry distinct domain meaning), but their algebraic witnesses could be derived via isomorphism to `Z.Modulo<2>` once that type exists.

Likely implementation: a small internal helper that transports group/field witnesses across an isomorphism.

**Reason deferred**: Non-critical ergonomics. The current hand-written witnesses are correct.

**Dependencies**: Requires `Algebra.Z.Modulo<2>` (item 1).

---

### 3. Semiring Witnesses

**Status**: Explicitly deferred.

Introduce `Algebra.Semiring` (and possibly `Algebra.Semiring.Commutative`) as a new node in the witness ladder below Ring.

Motivating examples:

- Boolean algebra (`||`, `&&`)
- Tropical semirings (min-plus, max-plus)
- Path-finding and dynamic programming structures

**Reason deferred**: Not required for current correctness fixes. Requires careful placement in the algebra ladder — a semiring has additive commutative monoid (not group) and multiplicative monoid, so it sits below Ring but is not simply "Ring minus inverses."

**Dependencies**: None, but should be placed before Module/VectorSpace work (item 5).

---

### 4. Law Test Harnesses (Finite Carriers)

**Status**: Deferred, recommended follow-up.

Property/law checking utilities that leverage `Finite_Primitives` to exhaustively verify algebraic laws over small carriers.

Example laws to verify:

- Group associativity: `a ∗ (b ∗ c) = (a ∗ b) ∗ c`
- Identity: `e ∗ a = a = a ∗ e`
- Inverse: `a ∗ a⁻¹ = e`
- Distributivity: `a · (b + c) = a·b + a·c`
- Commutativity: `a ∗ b = b ∗ a`

Particularly valuable for `Parity` (Z₂ field, currently the only canonical instance) and future `Z.Modulo<p>` instances.

Goal: turn documented invariants into mechanically audited ones.

**Reason deferred**: Non-breaking enhancement. No correctness issue exists — the current witnesses are correct by inspection, but exhaustive verification over finite carriers would increase confidence.

**Dependencies**: Requires `Finite_Primitives` (already exists). Benefits from `Algebra.Z.Modulo<n>` (item 1) for additional test carriers.

---

### 5. Module / VectorSpace Witnesses

**Status**: Deferred.

Higher algebraic structures:

- `Algebra.Module<R, M>` — ring action on additive group
- `Algebra.VectorSpace<F, V>` — field action (Module where scalar ring is a field)

These compose Ring/Field with Group to express linear structure.

**Reason deferred**: Higher algebra. Depends on stable Field design (now done) and possibly Semiring groundwork (item 3). Out of scope for the primitives correctness round.

**Dependencies**: Requires stable `Algebra.Field` (done). Benefits from `Algebra.Semiring` (item 3).

---

### 6. Canonical Instances Beyond Parity

**Status**: Deferred.

Currently `Parity` is the only carrier with a canonical field witness (`Algebra.Field<Parity>.z2`). Additional instances to consider:

| Carrier | Structure | Notes |
|---------|-----------|-------|
| `Bool` | Monoid(s) | `&&` and `||` monoids; semiring once item 3 exists |
| `FixedWidthInteger` types | Modular ring | Wraparound arithmetic provides ring structure |
| `Z.Modulo<n>` | Ring (always), Field (when n prime) | Depends on item 1 |

**Reason deferred**: Depends on `Algebra.Z.Modulo<n>` (item 1) and Semiring (item 3) for most interesting cases.

**Dependencies**: Items 1 and 3.

---

### 7. CaseSet Reintroduction in optic-primitives

**Status**: Deferred, moved out of this package.

`CaseSet` was deleted from algebra-primitives during this round (213 lines of implementation, 252 lines of tests removed in commit `ce7793f`). It had unclear semantics (ordered list vs true set) and compound naming issues.

Reintroduction requires:

- Correct naming per [API-NAME-001] (`Nest.Name` pattern)
- Clear semantics (set vs ordered collection)
- Placement in optic-primitives (due to `Optic.Prism` dependency)

**Reason deferred**: Wrong package. CaseSet's semantics depend on Prism, which lives in optic-primitives.

**Dependencies**: optic-primitives must define `Optic.Prism` first.

## Comparison

| Item | Status | Reason Deferred | Blocked By | Enables |
|------|--------|-----------------|------------|---------|
| 1. `Algebra.Z.Modulo<n>` | Design locked | Large addition | — | 2, 4, 6 |
| 2. Z₂ witness consolidation | Deferred | Ergonomic cleanup only | 1 | — |
| 3. Semiring | Deferred | New ladder node | — | 5, 6 |
| 4. Law test harnesses | Deferred | Non-breaking enhancement | — (benefits from 1) | — |
| 5. Module / VectorSpace | Deferred | Higher algebra | 3 (benefits from) | — |
| 6. Canonical instances | Deferred | Depends on other items | 1, 3 | — |
| 7. CaseSet reintroduction | Deferred | Wrong package | optic-primitives | — |

### Dependency Order

```
                ┌──────────────┐
                │ 1. Z.Modulo  │
                └──┬───┬───┬───┘
                   │   │   │
          ┌────────┘   │   └────────┐
          ▼            ▼            ▼
   ┌──────────┐  ┌──────────┐  ┌──────────┐
   │ 2. Z₂    │  │ 4. Law   │  │ 6. Canon │◄── also needs 3
   │ consol.  │  │ harness  │  │ instancs │
   └──────────┘  └──────────┘  └──────────┘

   ┌──────────┐       ┌──────────┐
   │ 3. Semi  │──────►│ 5. Mod/  │
   │ ring     │       │ VecSpc   │
   └──────────┘       └──────────┘

   ┌──────────┐
   │ 7. Case  │  (independent; depends on optic-primitives)
   │ Set      │
   └──────────┘
```

## Constraints

1. **No Foundation** — all items must remain Foundation-free ([PRIM-FOUND-001])
2. **Downward dependencies only** — no lateral or upward tier dependencies
3. **Nest.Name pattern** — all new types must follow [API-NAME-001]
4. **One type per file** — [API-IMPL-005]
5. **Typed throws** — any throwing operations must use typed throws ([API-ERR-001])

## Outcome

**Status**: DEFERRED

All correctness, naming, and totality issues are resolved in the current implementation. The items listed above are additive, non-breaking, and can be introduced incrementally without revisiting the Field design.

Recommended implementation order:

1. `Algebra.Z.Modulo<n>` (unlocks the most downstream work)
2. Law test harnesses (can begin without Z.Modulo but gains value from it)
3. Semiring (independent track, unlocks Module/VectorSpace)
4. Z₂ witness consolidation (after Z.Modulo exists)
5. Canonical instances (after Z.Modulo and Semiring)
6. Module / VectorSpace (after Semiring stabilizes)
7. CaseSet reintroduction (independent, blocked on optic-primitives)

## References

- `Algebra.Field+Parity.swift` — current Z₂ field witness (the pattern that item 2 would generalize)
- `Algebra.Group+Bound.swift`, `+Boundary.swift`, `+Endpoint.swift`, `+Gradient.swift` — the five Z₂ group witnesses exhibiting the duplication pattern
- `Algebra.Field.swift` — the converged Field design with typed throws
- `Algebra.Field.Unit.swift` — the Unit type for the multiplicative group of units
- `phase-rotation-placement.md` — related research on Phase/Z₄ placement
