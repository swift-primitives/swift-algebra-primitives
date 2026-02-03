// Algebra.Field+Z2.swift

/// Transports the canonical Z₂ field (Parity) across an isomorphism.
///
/// The transported field has:
/// - Additive group: transported via `Group.z2(via:)`
/// - Multiplicative monoid: transported AND operation
/// - Reciprocal: maps through iso, the one element is its own inverse,
///   the zero element throws `.nonInvertible`
extension Algebra.Field {
    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        return .init(
            additive: .z2(via: iso),
            multiplicative: .init(monoid: .init(
                identity: iso.backward(.odd),
                combining: { lhs, rhs in
                    iso.backward(Parity.multiplying(iso.forward(lhs), iso.forward(rhs)))
                }
            )),
            reciprocal: { (element) throws(Error) in
                guard iso.forward(element) == .odd else { throw .nonInvertible }
                return element
            }
        )
    }
}
