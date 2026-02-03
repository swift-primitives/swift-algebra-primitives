// Algebra.Law.Identity.swift

import Algebra_Field_Primitives

/// Identity law: e ∗ a = a (left), a ∗ e = a (right).
extension Algebra.Law {
    public enum Identity {}
}

extension Algebra.Law.Identity {
    /// Verifies left identity: e ∗ a = a for all a.
    @inlinable
    public static func left<Element: Equatable & Sendable, C: Collection<Element>>(
        of monoid: Algebra.Monoid<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            let lhs = monoid.combining(monoid.identity, a)
            if lhs != a {
                return .init(law: "identity-left", elements: [a], lhs: lhs, rhs: a)
            }
        }
        return nil
    }

    /// Verifies right identity: a ∗ e = a for all a.
    @inlinable
    public static func right<Element: Equatable & Sendable, C: Collection<Element>>(
        of monoid: Algebra.Monoid<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            let lhs = monoid.combining(a, monoid.identity)
            if lhs != a {
                return .init(law: "identity-right", elements: [a], lhs: lhs, rhs: a)
            }
        }
        return nil
    }
}
