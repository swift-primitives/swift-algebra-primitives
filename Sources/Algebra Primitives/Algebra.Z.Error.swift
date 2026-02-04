// Algebra.Z.Error.swift

/// Errors from modular arithmetic operations.
extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    public enum Error: Swift.Error, Sendable, Equatable {
        /// The modulus n is not positive.
        case modulus
        /// The residue is not in [0, n).
        case bounds(Int)
        /// Integer overflow during arithmetic operation.
        case arithmetic
    }
}
