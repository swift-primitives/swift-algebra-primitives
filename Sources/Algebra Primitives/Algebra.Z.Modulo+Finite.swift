// Algebra.Z.Modulo+Finite.swift

extension Algebra.Z.Modulo: Finite.Enumerable {
    /// Number of residue classes.
    @inlinable
    public static var count: Cardinal { Cardinal(UInt(n)) }

    /// Ordinal position of this residue.
    @inlinable
    public var ordinal: Ordinal { Ordinal(UInt(residue)) }

    /// Creates a residue from its ordinal.
    @inlinable
    public init(__unchecked: Void, ordinal: Ordinal) {
        self.init(__unchecked: Int(ordinal.rawValue))
    }
}
