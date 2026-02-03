// Algebra.Law.Action.swift

import Algebra_Module_Primitives

/// Identity action law: 1 · m = m.
extension Algebra.Law {
    public enum Action {}
}

extension Algebra.Law.Action {
    /// Verifies the identity action: 1 · m = m for all m.
    @inlinable
    public static func identity<Scalar: Sendable, Vector: Equatable & Sendable, C: Collection<Vector>>(
        of module: Algebra.Module<Scalar, Vector>,
        over vectors: C
    ) -> Algebra.Law.Violation<Vector>? {
        for m in vectors {
            let lhs = module.scaling(module.one, m)
            if lhs != m {
                return .init(law: "action-identity", elements: [m], lhs: lhs, rhs: m)
            }
        }
        return nil
    }
}
