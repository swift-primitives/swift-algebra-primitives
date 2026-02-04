// Algebra.Z.Residue.swift

/// Phantom tag carrying the modulus for Z/nZ.
///
/// Conforms to `Residual` (and therefore `Finite.Capacity`), providing
/// `capacity == n`. This enables `Tagged<Residue<n>, Ordinal>` to
/// automatically gain `Finite.Enumerable` conformance.
extension Algebra.Z {
    public enum Residue<let n: Int>: Residual, Hashable, Sendable {
        @inlinable
        public static var capacity: Int { n }
    }
}
