// Algebra.Group+Boundary.swift

/// Z₂ group witness for Boundary.
///
/// Boundary forms a Z₂ group under the toggle operation:
/// - Identity: closed
/// - closed ∗ closed = closed, open ∗ open = closed
/// - closed ∗ open = open, open ∗ closed = open
/// - Every element is its own inverse
extension Algebra.Group where Element == Boundary {
    /// The Z₂ group over boundary inclusivity.
    @inlinable
    public static var z2: Self {
        .init(
            identity: .closed,
            combining: { lhs, rhs in lhs == rhs ? .closed : .open },
            inverting: { $0 }
        )
    }
}
