// Algebra.Law.Commutativity.swift

import Algebra_Field_Primitives

/// Commutativity law: a ∗ b = b ∗ a.
extension Algebra.Law {
    /// Harness for the commutativity law: a ∗ b = b ∗ a.
    public enum Commutativity {}
}

extension Algebra.Law.Commutativity {
    /// Verifies commutativity of a binary operation over the given elements.
    @inlinable
    public static func check<Element: Equatable, C: Collection<Element>>(
        of combining: @Sendable (Element, Element) -> Element,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            for b in elements {
                let lhs = combining(a, b)
                let rhs = combining(b, a)
                if lhs != rhs {
                    return .init(law: "commutativity", elements: [a, b], lhs: lhs, rhs: rhs)
                }
            }
        }
        return nil
    }
}
