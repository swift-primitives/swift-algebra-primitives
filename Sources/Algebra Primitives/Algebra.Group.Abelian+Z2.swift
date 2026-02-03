// Algebra.Group.Abelian+Z2.swift

/// Transports the canonical Z₂ abelian group (Parity) across an isomorphism.
extension Algebra.Group.Abelian {
    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        .init(group: .z2(via: iso))
    }
}
