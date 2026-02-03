// Algebra.Field+Parity.swift

/// Z₂ field witness for Parity.
///
/// Parity forms the Z₂ field:
/// - Addition (XOR): even + even = even, odd + odd = even, even + odd = odd
/// - Multiplication (AND): odd × odd = odd, all others even
/// - Additive identity: even
/// - Multiplicative identity: odd
/// - Every element is its own additive inverse
extension Algebra.Field where Element == Parity {
    /// The Z₂ field over parity.
    @inlinable
    public static var z2: Self {
        .init(
            additive: .init(group: .init(
                identity: .even,
                combining: Parity.adding,
                inverting: { $0 }
            )),
            multiplicative: .init(group: .init(
                identity: .odd,
                combining: Parity.multiplying,
                inverting: { $0 }
            ))
        )
    }
}
