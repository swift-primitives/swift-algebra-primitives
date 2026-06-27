// Algebra.VectorSpace+Module.swift

import Algebra_Field_Primitives

extension Algebra.VectorSpace {
    /// Projects to a module by forgetting field structure (keeping ring).
    @inlinable
    public var module: Algebra.Module<Scalar, Vector> {
        .init(
            scalars: scalars.ring.ring,
            vectors: vectors,
            scaling: scaling
        )
    }
}
