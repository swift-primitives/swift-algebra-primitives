// Algebra.Module+Convenience.swift

import Algebra_Field_Primitives

extension Algebra.Module {
    /// The zero vector.
    @inlinable
    public var zero: Vector { vectors.identity }

    /// The scalar one.
    @inlinable
    public var one: Scalar { scalars.one }

    /// Vector addition.
    @inlinable
    public func adding(_ lhs: Vector, _ rhs: Vector) -> Vector {
        vectors.combining(lhs, rhs)
    }

    /// Additive inverse of a vector.
    @inlinable
    public func negating(_ vector: Vector) -> Vector {
        vectors.inverting(vector)
    }
}
