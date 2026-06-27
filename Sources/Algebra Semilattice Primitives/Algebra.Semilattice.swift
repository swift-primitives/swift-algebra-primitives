// Algebra.Semilattice.swift

import Algebra_Monoid_Primitives

/// Witness for a (bounded join-)semilattice: an associative, commutative,
/// idempotent binary operation with an identity element.
///
/// A bounded semilattice (S, ∨, ⊥) is a set S with a binary operation ∨
/// and an identity element ⊥ such that for all a, b, c ∈ S:
/// - **Associativity**: (a ∨ b) ∨ c = a ∨ (b ∨ c)
/// - **Commutativity**: a ∨ b = b ∨ a
/// - **Idempotency**: a ∨ a = a
/// - **Identity**: ⊥ ∨ a = a ∨ ⊥ = a
///
/// The operation ∨ induces a partial order on S where a ≤ b ⟺ a ∨ b = b.
/// The identity element ⊥ is the bottom of this order (least upper bound
/// of the empty set).
///
/// Bounded semilattices are the algebraic foundation for **state-based
/// CRDTs (CvRDTs)**: the merge operation of any convergent replicated
/// data type is a join-semilattice operation, and SEC (Strong Eventual
/// Consistency) follows from the semilattice laws (Shapiro et al.,
/// *Conflict-Free Replicated Data Types*, SSS 2011).
///
/// Idempotency, commutativity, and identity are documented invariants —
/// not enforced at compile time. Conformers MUST guarantee them or
/// downstream CRDT-style merging will fail to converge.
///
/// ## Example
///
/// ```swift
/// // Max semilattice on Int with bottom = .min
/// let maxLattice = Algebra.Semilattice<Int>(
///     monoid: .init(monoid: .init(identity: .min, combining: max))
/// )
/// maxLattice.combining(3, 7)        // 7
/// maxLattice.combining(7, 7)        // 7  (idempotent)
/// maxLattice.combining(.min, 5)     // 5  (identity)
/// ```
///
/// ## Relation to other algebraic structures
///
/// | Structure | Operation laws |
/// |-----------|----------------|
/// | Magma | binary op |
/// | Semigroup | + associative |
/// | Monoid | + identity |
/// | `Algebra.Monoid.Commutative` | + commutative |
/// | **`Algebra.Semilattice`** | **+ idempotent** |
/// | Group | (alternate path) Monoid + inverses (no idempotency) |
extension Algebra {
    /// A commutative monoid whose operation is additionally idempotent, the join of a bounded join-semilattice.
    @frozen
    public struct Semilattice<Element> {
        /// The underlying commutative monoid (associative + commutative + identity).
        ///
        /// Idempotency (a ∨ a = a) is the additional documented invariant.
        public var monoid: Algebra.Monoid<Element>.Commutative

        /// Creates a semilattice from a commutative monoid whose operation is asserted idempotent.
        @inlinable
        public init(monoid: Algebra.Monoid<Element>.Commutative) {
            self.monoid = monoid
        }
    }
}

// MARK: - Sendable

extension Algebra.Semilattice: Sendable where Element: Sendable {}

// MARK: - Accessors

extension Algebra.Semilattice {
    /// The identity element (bottom of the induced partial order).
    @inlinable
    public var identity: Element { monoid.identity }

    /// The associative, commutative, idempotent binary operation.
    @inlinable
    public var combining: (Element, Element) -> Element { monoid.combining }

    /// Applies the semilattice operation.
    @inlinable
    public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
        combining(lhs, rhs)
    }

    /// The semilattice operation, alternately spelled `join` to mirror the
    /// lattice-theoretic vocabulary (a ∨ b is the least upper bound of
    /// {a, b} in the induced partial order).
    @inlinable
    public func join(_ lhs: Element, _ rhs: Element) -> Element {
        combining(lhs, rhs)
    }
}

// MARK: - Convenience constructor

extension Algebra.Semilattice {
    /// Creates a semilattice directly from identity and combining function.
    ///
    /// Bypasses the explicit `Algebra.Monoid.Commutative` wrapping. The
    /// caller is responsible for ensuring the operation is associative,
    /// commutative, and idempotent with `identity` as its bottom element.
    @inlinable
    public init(
        identity: Element,
        combining: @escaping (Element, Element) -> Element
    ) {
        self.init(monoid: .init(monoid: .init(identity: identity, combining: combining)))
    }
}

// MARK: - Partial-order projection

extension Algebra.Semilattice {
    /// Returns true iff `lhs ≤ rhs` in the induced partial order.
    ///
    /// The order is defined as `lhs ∨ rhs == rhs`. Requires `Element: Equatable`.
    @inlinable
    public func leq(_ lhs: Element, _ rhs: Element) -> Bool where Element: Equatable {
        combining(lhs, rhs) == rhs
    }
}
