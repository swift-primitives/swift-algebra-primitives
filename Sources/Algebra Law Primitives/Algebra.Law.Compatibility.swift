// Algebra.Law.Compatibility.swift

import Algebra_Module_Primitives

/// Scalar compatibility law: (r · s) · m = r · (s · m).
extension Algebra.Law {
    public enum Compatibility {}
}

extension Algebra.Law.Compatibility {
    /// Verifies scalar compatibility of a module over the given elements.
    @inlinable
    public static func scalar<Scalar: Equatable & Sendable, Vector: Equatable & Sendable, CS: Collection<Scalar>, CV: Collection<Vector>>(
        of module: Algebra.Module<Scalar, Vector>,
        over scalars: CS,
        _ vectors: CV
    ) -> Algebra.Law.Violation<Vector>? {
        for r in scalars {
            for s in scalars {
                for m in vectors {
                    let lhs = module.scaling(module.scalars.multiplying(r, s), m)
                    let rhs = module.scaling(r, module.scaling(s, m))
                    if lhs != rhs {
                        return .init(law: "compatibility", elements: [lhs, rhs], lhs: lhs, rhs: rhs)
                    }
                }
            }
        }
        return nil
    }
}
