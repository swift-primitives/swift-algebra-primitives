// Algebra.Z.Modulo+Semiring.swift

/// Commutative semiring witness for Z/nZ.
///
/// Returns nil if the ring witness is nil (overflow for large moduli).
extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    @inlinable
    public static var semiring: Algebra.Semiring<Self>.Commutative? {
        ring?.semiring
    }
}
