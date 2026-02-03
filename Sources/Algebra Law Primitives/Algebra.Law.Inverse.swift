// Algebra.Law.Inverse.swift

import Algebra_Field_Primitives

/// Inverse law: a⁻¹ ∗ a = e (left), a ∗ a⁻¹ = e (right).
extension Algebra.Law {
    public enum Inverse {}
}

extension Algebra.Law.Inverse {
    /// Verifies left inverse: a⁻¹ ∗ a = e for all a.
    @inlinable
    public static func left<Element: Equatable & Sendable, C: Collection<Element>>(
        of group: Algebra.Group<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            let lhs = group.combining(group.inverting(a), a)
            if lhs != group.identity {
                return .init(law: "inverse-left", elements: [a], lhs: lhs, rhs: group.identity)
            }
        }
        return nil
    }

    /// Verifies right inverse: a ∗ a⁻¹ = e for all a.
    @inlinable
    public static func right<Element: Equatable & Sendable, C: Collection<Element>>(
        of group: Algebra.Group<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            let lhs = group.combining(a, group.inverting(a))
            if lhs != group.identity {
                return .init(law: "inverse-right", elements: [a], lhs: lhs, rhs: group.identity)
            }
        }
        return nil
    }
}
