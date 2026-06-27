// Algebra.Lattice.swift

import Algebra_Semilattice_Primitives

/// Witness for a **bounded lattice**: a set L with two binary operations —
/// join (∨, least upper bound) and meet (∧, greatest lower bound) — each an
/// associative, commutative, idempotent (bounded) semilattice, connected by
/// the **absorption** laws and equipped with a bottom (⊥) and top (⊤).
///
/// A bounded lattice (L, ∨, ∧, ⊥, ⊤) satisfies, for all a, b, c ∈ L:
/// - **Join and meet are semilattices**: each associative, commutative, and
///   idempotent (the `Algebra.Semilattice` laws).
/// - **Absorption**: a ∨ (a ∧ b) = a   and   a ∧ (a ∨ b) = a.
/// - **Bounds (identities)**: a ∨ ⊥ = a (⊥ = the join identity, the least
///   element) and a ∧ ⊤ = a (⊤ = the meet identity, the greatest element).
///
/// Join and meet induce the **same** partial order: a ≤ b ⟺ a ∨ b = b ⟺
/// a ∧ b = a. The bottom ⊥ is the least element of that order; the top ⊤ is
/// the greatest.
///
/// Absorption (and, for a *distributive* lattice, distributivity) are
/// **documented invariants** — not enforced at compile time. Conformers MUST
/// guarantee them.
///
/// ## Example
///
/// ```swift
/// // The min/max lattice on Int: join = max, meet = min.
/// let chain = Algebra.Lattice<Int>.minMax(bottom: .min, top: .max)
/// chain.join(3, 7)   // 7   (∨ = max)
/// chain.meet(3, 7)   // 3   (∧ = min)
/// chain.leq(3, 7)    // true
/// ```
///
/// ## Canonical example — the powerset lattice
///
/// For the powerset of a universe U: ∨ = ∪, ∧ = ∩, ⊥ = ∅, ⊤ = U, with ⊆ the
/// induced order. The powerset is in fact a *Boolean* algebra (a complemented
/// distributive bounded lattice); its complement is a native operation, not a
/// separate witness — `Swift.Bool` is the canonical Boolean algebra
/// (`swift-bool-algebra-primitives`). This is the formal grounding for
/// `swift-set-algebra-primitives` (Birkhoff; Stone).
///
/// ## Relation to other algebraic structures
///
/// | Structure | Operations |
/// |-----------|------------|
/// | `Algebra.Semilattice` | one idempotent commutative monoid (∨ *or* ∧) |
/// | **`Algebra.Lattice`** | **join ∨ + meet ∧ + absorption + bounds** |
/// | Boolean algebra (`Swift.Bool`) | + distributivity + complement (native) |
extension Algebra {
    /// A bounded lattice: join and meet semilattices linked by absorption, with a bottom and a top.
    @frozen
    public struct Lattice<Element> {
        /// The join (∨) semilattice — least upper bound; its identity is the
        /// lattice bottom (⊥).
        ///
        /// `lattice.join(a, b)` computes a ∨ b.
        public var join: Algebra.Semilattice<Element>

        /// The meet (∧) semilattice — greatest lower bound; its identity is the
        /// lattice top (⊤).
        ///
        /// `lattice.meet(a, b)` computes a ∧ b.
        public var meet: Algebra.Semilattice<Element>

        /// Creates a bounded lattice from its join and meet semilattices.
        @inlinable
        public init(
            join: Algebra.Semilattice<Element>,
            meet: Algebra.Semilattice<Element>
        ) {
            self.join = join
            self.meet = meet
        }
    }
}

// MARK: - Sendable

extension Algebra.Lattice: Sendable where Element: Sendable {}

// MARK: - Bounds

extension Algebra.Lattice {
    /// Bottom (⊥) — the join identity; the least element of the induced order.
    @inlinable
    public var bottom: Element { join.identity }

    /// Top (⊤) — the meet identity; the greatest element of the induced order.
    @inlinable
    public var top: Element { meet.identity }
}

// MARK: - Convenience constructor

extension Algebra.Lattice {
    /// Creates a bounded lattice directly from its bounds and operations.
    ///
    /// Bypasses the explicit `Algebra.Semilattice` wrapping. The caller is
    /// responsible for ensuring join/meet are each associative, commutative,
    /// and idempotent, that absorption holds between them, and that `bottom`
    /// (⊥) and `top` (⊤) are the respective identities.
    @inlinable
    public init(
        bottom: Element,
        join: @escaping (Element, Element) -> Element,
        top: Element,
        meet: @escaping (Element, Element) -> Element
    ) {
        self.init(
            join: .init(identity: bottom, combining: join),
            meet: .init(identity: top, combining: meet)
        )
    }
}

// MARK: - Partial-order projection

extension Algebra.Lattice {
    /// Returns true iff `lhs ≤ rhs` in the induced partial order.
    ///
    /// The order is defined as `lhs ∨ rhs == rhs` (equivalently
    /// `lhs ∧ rhs == lhs`). Requires `Element: Equatable`.
    @inlinable
    public func leq(_ lhs: Element, _ rhs: Element) -> Bool where Element: Equatable {
        join(lhs, rhs) == rhs
    }
}
