// Algebra.Law.Annihilation.swift

import Algebra_Field_Primitives

/// Annihilation law: 0 · a = 0 and a · 0 = 0.
extension Algebra.Law {
    public enum Annihilation {}
}

extension Algebra.Law.Annihilation {
    /// Verifies zero annihilation: 0 · a = 0 and a · 0 = 0 for all a.
    @inlinable
    public static func zero<Element: Equatable & Sendable, C: Collection<Element>>(
        of ring: Algebra.Ring<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            let lhs = ring.multiplying(ring.zero, a)
            if lhs != ring.zero {
                return .init(law: "annihilation-left", elements: [a], lhs: lhs, rhs: ring.zero)
            }
            let rhs = ring.multiplying(a, ring.zero)
            if rhs != ring.zero {
                return .init(law: "annihilation-right", elements: [a], lhs: rhs, rhs: ring.zero)
            }
        }
        return nil
    }
}
