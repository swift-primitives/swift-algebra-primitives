// Algebra.Module.swift

import Algebra_Field_Primitives

/// Witness for a module: a scalar ring acting on an abelian group of vectors.
///
/// A module (R, M, ·) satisfies:
/// - R is a ring (the scalars)
/// - M is an abelian group (the vectors)
/// - Scalar multiplication · : R × M → M distributes over both
///   vector addition and scalar addition
/// - Scalar multiplication is compatible with ring multiplication:
///   (r · s) · m = r · (s · m)
/// - The ring identity acts as identity: 1 · m = m
///
/// Distributivity and compatibility are documented invariants.
extension Algebra {
    /// A scalar ring acting on an abelian group of vectors via distributive, compatible scalar multiplication.
    @frozen
    public struct Module<Scalar, Vector> {
        /// The ring of scalars.
        public var scalars: Algebra.Ring<Scalar>

        /// The abelian group of vectors.
        public var vectors: Algebra.Group<Vector>.Abelian

        /// Scalar multiplication.
        public var scaling: (Scalar, Vector) -> Vector

        /// Creates a module from its scalar ring, vector abelian group, and scalar multiplication.
        @inlinable
        public init(
            scalars: Algebra.Ring<Scalar>,
            vectors: Algebra.Group<Vector>.Abelian,
            scaling: @escaping (Scalar, Vector) -> Vector
        ) {
            self.scalars = scalars
            self.vectors = vectors
            self.scaling = scaling
        }
    }
}

// MARK: - Sendable

// SAFETY: Category D (SP-4, [MEM-SAFE-024]) — the stored `scaling` closure is a
// SAFETY: plain (non-@Sendable) function under the region-isolation policy, which
// SAFETY: blocks Sendable synthesis; the witness wraps a pure operation, so sharing
// SAFETY: is safe. The conditional bounds keep the conformance non-unconditional ([MEM-SEND-001]).
extension Algebra.Module: @unchecked Sendable where Scalar: Sendable, Vector: Sendable {}
