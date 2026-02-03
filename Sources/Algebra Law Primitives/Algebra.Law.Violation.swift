// Algebra.Law.Violation.swift

import Algebra_Field_Primitives

/// A record of a law violation found during verification.
///
/// Contains the law name, the elements that produced the violation,
/// and the left/right sides that should have been equal.
extension Algebra.Law {
    @frozen
    public struct Violation<Element: Sendable>: Sendable {
        /// The name of the violated law.
        public var law: String

        /// The elements that produced the violation.
        public var elements: [Element]

        /// The left-hand side of the failed equation.
        public var lhs: Element

        /// The right-hand side of the failed equation.
        public var rhs: Element

        @inlinable
        public init(law: String, elements: [Element], lhs: Element, rhs: Element) {
            self.law = law
            self.elements = elements
            self.lhs = lhs
            self.rhs = rhs
        }
    }
}
