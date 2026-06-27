// Algebra.VectorSpace.swift

import Algebra_Field_Primitives

/// Witness for a vector space: a scalar field acting on an abelian group of vectors.
///
/// A vector space is a module where the scalars form a field.
/// This provides division of scalars and guarantees all nonzero
/// scalars have multiplicative inverses.
extension Algebra {
    /// A module whose scalars form a field, so every nonzero scalar is invertible.
    @frozen
    public struct VectorSpace<Scalar, Vector> {
        /// The field of scalars.
        public var scalars: Algebra.Field<Scalar>

        /// The abelian group of vectors.
        public var vectors: Algebra.Group<Vector>.Abelian

        /// Scalar multiplication.
        public var scaling: (Scalar, Vector) -> Vector

        /// Creates a vector space from its scalar field, vector abelian group, and scalar multiplication.
        @inlinable
        public init(
            scalars: Algebra.Field<Scalar>,
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
extension Algebra.VectorSpace: @unchecked Sendable where Scalar: Sendable, Vector: Sendable {}
