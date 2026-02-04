// Algebra.Z.Modulo.swift

/// Integer residue class Z/nZ.
///
/// Represents elements of the quotient ring of integers modulo n.
/// The raw value is an ordinal in the range [0, n). The modulus n
/// must be positive; all public construction throws for n ≤ 0.
///
/// `Modulo<n>` is a `Tagged<Residue<n>, Ordinal>`, gaining
/// `Finite.Enumerable`, `Hashable`, `Comparable`, and `Sendable`
/// for free.
///
/// ## Example
///
/// ```swift
/// let a = try Algebra.Z.Modulo<5>(wrapping: 7)   // ordinal 2
/// let b = try Algebra.Z.Modulo<5>(wrapping: -1)  // ordinal 4
/// let c = a + b                                    // ordinal 1
/// ```
extension Algebra.Z {
    public typealias Modulo<let n: Int> = Tagged<Residue<n>, Ordinal>
}

// MARK: - Construction

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    /// Creates a residue class element with bounds checking.
    ///
    /// - Throws: `Error.modulus` if n ≤ 0.
    /// - Throws: `Error.bounds` if residue is not in [0, n).
    @inlinable
    public init(_ residue: Int) throws(Error) {
        let n = Tag.capacity
        guard n > 0 else { throw .modulus }
        guard residue >= 0, residue < n else { throw .bounds(residue) }
        self.init(__unchecked: (), Ordinal(UInt(residue)))
    }

    /// Creates a residue class element via modular reduction.
    ///
    /// Reduces any integer to the canonical representative in [0, n).
    /// Handles negative values correctly.
    ///
    /// - Throws: `Error.modulus` if n ≤ 0.
    @inlinable
    public init(wrapping value: Int) throws(Error) {
        let n = Tag.capacity
        guard n > 0 else { throw .modulus }
        let r = value % n
        let normalized = r < 0 ? r + n : r
        self.init(__unchecked: (), Ordinal(UInt(normalized)))
    }
}
