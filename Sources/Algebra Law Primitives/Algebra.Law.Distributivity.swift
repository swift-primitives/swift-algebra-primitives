// Algebra.Law.Distributivity.swift

import Algebra_Module_Primitives

/// Distributivity law: a · (b + c) = a·b + a·c (left), (a + b) · c = a·c + b·c (right).
extension Algebra.Law {
    /// Harness for the distributivity law: a · (b + c) = a·b + a·c (left), (a + b) · c = a·c + b·c (right).
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

    /// Verifies scalar distributivity over vector addition: r·(v+w) = r·v + r·w.
    @inlinable
    public static func scalar<
        Scalar: Sendable,
        Vector: Equatable & Sendable,
        CS: Collection<Scalar>,
        CV: Collection<Vector>
    >(
        of module: Algebra.Module<Scalar, Vector>,
        over scalars: CS,
        _ vectors: CV
    ) -> Algebra.Law.Violation<Vector>? {
        for r in scalars {
            for v in vectors {
                for w in vectors {
                    let lhs = module.scaling(r, module.vectors.combining(v, w))
                    let rhs = module.vectors.combining(module.scaling(r, v), module.scaling(r, w))
                    if lhs != rhs {
                        return .init(law: "distributivity-scalar", elements: [lhs, rhs], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }

    /// Verifies scalar addition distributivity: (r+s)·v = r·v + s·v.
    @inlinable
    public static func addition<
        Scalar: Equatable & Sendable,
        Vector: Equatable & Sendable,
        CS: Collection<Scalar>,
        CV: Collection<Vector>
    >(
        of module: Algebra.Module<Scalar, Vector>,
        over scalars: CS,
        _ vectors: CV
    ) -> Algebra.Law.Violation<Vector>? {
        for r in scalars {
            for s in scalars {
                for v in vectors {
                    let lhs = module.scaling(module.scalars.adding(r, s), v)
                    let rhs = module.vectors.combining(module.scaling(r, v), module.scaling(s, v))
                    if lhs != rhs {
                        return .init(law: "distributivity-addition", elements: [lhs, rhs], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }
}
