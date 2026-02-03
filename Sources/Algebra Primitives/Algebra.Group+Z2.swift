// Algebra.Group+Z2.swift

/// Transports the canonical Z₂ group (Parity) across an isomorphism.
///
/// Given an isomorphism between Element and Parity, constructs a Z₂ group
/// on Element by mapping through the isomorphism. The identity is the
/// element corresponding to `.even`, and every element is self-inverse.
extension Algebra.Group {
    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        .init(
            identity: iso.backward(.even),
            combining: { lhs, rhs in
                iso.backward(Parity.adding(iso.forward(lhs), iso.forward(rhs)))
            },
            inverting: { $0 }
        )
    }
}
