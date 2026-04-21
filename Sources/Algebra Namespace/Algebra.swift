// Algebra.swift

/// Namespace for algebraic structures and type-safe primitives.
///
/// Provides witness structs for the standard algebraic hierarchy:
/// magma, semigroup, monoid, group, ring, and field. Each witness
/// captures the operations of its algebraic structure as closures,
/// with the type name communicating the mathematical invariants.
///
/// ## Example
///
/// ```swift
/// let z2 = Algebra.Field<Bit>.z2
/// z2.additive.combining(.one, .one)   // .zero (XOR)
/// z2.multiplicative.combining(.one, .one) // .one (AND)
/// ```
public enum Algebra {}
