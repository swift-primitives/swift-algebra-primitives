// Algebra.Field+Parity.swift

/// Z₂ field witness for Parity.
///
/// Parity forms the Z₂ field:
/// - Addition (XOR): even + even = even, odd + odd = even, even + odd = odd
/// - Multiplication (AND): odd × odd = odd, all others even
/// - Additive identity: even
/// - Multiplicative identity: odd
/// - Every element is its own additive inverse
/// - Reciprocal of odd is odd; even has no reciprocal (zero element)
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
            multiplicative: .init(monoid: .init(
                identity: .odd,
                combining: Parity.multiplying
            )),
            reciprocal: { (element) throws(Error) in
                guard element == .odd else { throw .nonInvertible }
                return element
            }
        )
    }
}
