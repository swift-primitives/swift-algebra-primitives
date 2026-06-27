// Algebra.VectorSpace+Convenience.swift

import Algebra_Field_Primitives

extension Algebra.VectorSpace {
    /// The zero vector.
    @inlinable
    public var zero: Vector { vectors.identity }

    /// Vector addition.
    @inlinable
    public func adding(_ lhs: Vector, _ rhs: Vector) -> Vector {
        vectors.combining(lhs, rhs)
    }

    /// Vector subtraction.
    @inlinable
    public func subtracting(_ lhs: Vector, _ rhs: Vector) -> Vector {
        vectors.combining(lhs, vectors.inverting(rhs))
    }

    /// Additive inverse of a vector.
    @inlinable
    public func negating(_ vector: Vector) -> Vector {
        vectors.inverting(vector)
    }
}
