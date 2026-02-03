// Algebra.Group+Parity.swift

/// Z₂ group witnesses for Parity.
///
/// Parity forms abelian groups under both addition and multiplication.
extension Algebra.Group where Element == Parity {
    /// Additive Z₂ group: combining is XOR-like parity addition.
    @inlinable
    public static var additive: Self {
        .init(
            identity: .even,
            combining: Parity.adding,
            inverting: { $0 }
        )
    }
}
