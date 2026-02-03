// Algebra.Group+Gradient.swift

/// Z₂ group witness for Gradient.
///
/// Gradient forms a Z₂ group under the reversal operation:
/// - Identity: ascending
/// - ascending ∗ ascending = ascending, descending ∗ descending = ascending
/// - ascending ∗ descending = descending, descending ∗ ascending = descending
/// - Every element is its own inverse
extension Algebra.Group where Element == Gradient {
    /// The Z₂ group over gradient direction.
    @inlinable
    public static var z2: Self {
        .init(
            identity: .ascending,
            combining: { lhs, rhs in lhs == rhs ? .ascending : .descending },
            inverting: { $0 }
        )
    }
}
