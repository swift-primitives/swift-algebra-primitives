// Algebra.Law.Associativity.swift

import Algebra_Field_Primitives

/// Associativity law: (a ∗ b) ∗ c = a ∗ (b ∗ c).
extension Algebra.Law {
    public enum Associativity {}
}

extension Algebra.Law.Associativity {
    /// Verifies associativity of a semigroup over the given elements.
    @inlinable
    public static func check<Element: Equatable & Sendable, C: Collection<Element>>(
        of semigroup: Algebra.Semigroup<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            for b in elements {
                for c in elements {
                    let lhs = semigroup.combining(semigroup.combining(a, b), c)
                    let rhs = semigroup.combining(a, semigroup.combining(b, c))
                    if lhs != rhs {
                        return .init(law: "associativity", elements: [a, b, c], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }
}
