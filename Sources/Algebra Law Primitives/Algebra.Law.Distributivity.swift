// Algebra.Law.Distributivity.swift

import Algebra_Field_Primitives

/// Distributivity law: a · (b + c) = a·b + a·c (left), (a + b) · c = a·c + b·c (right).
extension Algebra.Law {
    public enum Distributivity {}
}

extension Algebra.Law.Distributivity {
    /// Verifies left distributivity: a · (b + c) = a·b + a·c.
    @inlinable
    public static func left<Element: Equatable & Sendable, C: Collection<Element>>(
        of ring: Algebra.Ring<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            for b in elements {
                for c in elements {
                    let lhs = ring.multiplying(a, ring.adding(b, c))
                    let rhs = ring.adding(ring.multiplying(a, b), ring.multiplying(a, c))
                    if lhs != rhs {
                        return .init(law: "distributivity-left", elements: [a, b, c], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }

    /// Verifies right distributivity: (a + b) · c = a·c + b·c.
    @inlinable
    public static func right<Element: Equatable & Sendable, C: Collection<Element>>(
        of ring: Algebra.Ring<Element>,
        over elements: C
    ) -> Algebra.Law.Violation<Element>? {
        for a in elements {
            for b in elements {
                for c in elements {
                    let lhs = ring.multiplying(ring.adding(a, b), c)
                    let rhs = ring.adding(ring.multiplying(a, c), ring.multiplying(b, c))
                    if lhs != rhs {
                        return .init(law: "distributivity-right", elements: [a, b, c], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }
}
