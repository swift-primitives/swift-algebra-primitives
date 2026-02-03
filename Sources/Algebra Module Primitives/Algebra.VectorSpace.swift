// Algebra.VectorSpace.swift

import Algebra_Field_Primitives
public import Witness_Primitives

/// Witness for a vector space: a scalar field acting on an abelian group of vectors.
///
/// A vector space is a module where the scalars form a field.
/// This provides division of scalars and guarantees all nonzero
/// scalars have multiplicative inverses.
extension Algebra {
    @frozen
    public struct VectorSpace<Scalar: Sendable, Vector: Sendable>: Sendable, Witness.`Protocol` {
        /// The field of scalars.
        public var scalars: Algebra.Field<Scalar>

        /// The abelian group of vectors.
        public var vectors: Algebra.Group<Vector>.Abelian

        /// Scalar multiplication.
        public var scaling: @Sendable (Scalar, Vector) -> Vector

        @inlinable
        public init(
            scalars: Algebra.Field<Scalar>,
            vectors: Algebra.Group<Vector>.Abelian,
            scaling: @escaping @Sendable (Scalar, Vector) -> Vector
        ) {
            self.scalars = scalars
            self.vectors = vectors
            self.scaling = scaling
        }
    }
}
