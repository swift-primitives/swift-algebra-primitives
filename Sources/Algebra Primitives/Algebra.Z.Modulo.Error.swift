// Algebra.Z.Modulo.Error.swift

/// Errors from modular arithmetic operations.
extension Algebra.Z.Modulo {
    public enum Error: Swift.Error, Sendable, Equatable {
        /// The modulus n is not positive.
        case modulus
        /// The residue is not in [0, n).
        case bounds(Int)
        /// Integer overflow during arithmetic operation.
        case arithmetic
    }
}
