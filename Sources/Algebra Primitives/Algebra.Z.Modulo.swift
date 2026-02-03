// Algebra.Z.Modulo.swift

/// Integer residue class Z/nZ.
///
/// Represents elements of the quotient ring of integers modulo n.
/// The residue is an integer in the range [0, n). The modulus n
/// must be positive.
///
/// ## Example
///
/// ```swift
/// let a = Algebra.Z.Modulo<5>(wrapping: 7)   // residue 2
/// let b = Algebra.Z.Modulo<5>(wrapping: -1)  // residue 4
/// let c = a + b                               // residue 1
/// ```
extension Algebra.Z {
    @frozen
    public struct Modulo<let n: Int>: Hashable, Comparable, Sendable {
        /// The residue in [0, n).
        public let residue: Int

        /// Creates a residue class element with bounds checking.
        ///
        /// - Throws: `Error.modulus` if n ≤ 0.
        /// - Throws: `Error.bounds` if residue is not in [0, n).
        @inlinable
        public init(_ residue: Int) throws(Error) {
            guard n > 0 else { throw .modulus }
            guard residue >= 0, residue < n else { throw .bounds(residue) }
            self.residue = residue
        }

        /// Creates a residue class element via modular reduction.
        ///
        /// Reduces any integer to the canonical representative in [0, n).
        /// Handles negative values correctly.
        @inlinable
        public init(wrapping value: Int) {
            let r = value % n
            self.residue = r < 0 ? r + n : r
        }

        /// Creates a residue class element without validation.
        ///
        /// The caller must guarantee that `residue` is in [0, n).
        @inlinable
        public init(__unchecked residue: Int) {
            self.residue = residue
        }
    }
}

// MARK: - Comparable

extension Algebra.Z.Modulo {
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.residue < rhs.residue
    }
}
