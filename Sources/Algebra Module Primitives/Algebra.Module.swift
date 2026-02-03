// Algebra.Module.swift

import Algebra_Field_Primitives
public import Witness_Primitives

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
    @frozen
    public struct Module<Scalar: Sendable, Vector: Sendable>: Sendable, Witness.`Protocol` {
        /// The ring of scalars.
        public var scalars: Algebra.Ring<Scalar>

        /// The abelian group of vectors.
        public var vectors: Algebra.Group<Vector>.Abelian

        /// Scalar multiplication.
        public var scaling: @Sendable (Scalar, Vector) -> Vector

        @inlinable
        public init(
            scalars: Algebra.Ring<Scalar>,
            vectors: Algebra.Group<Vector>.Abelian,
            scaling: @escaping @Sendable (Scalar, Vector) -> Vector
        ) {
            self.scalars = scalars
            self.vectors = vectors
            self.scaling = scaling
        }
    }
}
