// Algebra.Field.Unit.swift

import Algebra_Ring_Primitives

/// An element proven to be multiplicatively invertible.
///
/// `Unit` values can only be constructed through `Field.unit(_:)`,
/// which verifies invertibility by calling `reciprocal`. Both the
/// element and its precomputed inverse are stored, making all
/// group operations on units total.
extension Algebra.Field {
    /// A field element together with its precomputed multiplicative inverse, proving it is a unit.
    @frozen
    public struct Unit {
        /// The element value.
        public var element: Element

        /// The precomputed multiplicative inverse.
        public var inverse: Element

        @usableFromInline
        internal init(element: Element, inverse: Element) {
            self.element = element
            self.inverse = inverse
        }
    }
}

// MARK: - Sendable

extension Algebra.Field.Unit: Sendable where Element: Sendable {}
