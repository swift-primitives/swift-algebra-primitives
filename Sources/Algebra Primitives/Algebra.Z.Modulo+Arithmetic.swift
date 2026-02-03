// Algebra.Z.Modulo+Arithmetic.swift

extension Algebra.Z.Modulo {
    /// Additive identity.
    @inlinable
    public static var zero: Self { .init(__unchecked: 0) }

    /// Multiplicative identity.
    @inlinable
    public static var one: Self { .init(__unchecked: n > 1 ? 1 : 0) }

    /// Additive inverse.
    @inlinable
    public var negated: Self {
        residue == 0 ? self : .init(__unchecked: n - residue)
    }
}

// MARK: - Addition

extension Algebra.Z.Modulo {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        let sum = lhs.residue + rhs.residue
        return .init(__unchecked: sum >= n ? sum - n : sum)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: - Subtraction

extension Algebra.Z.Modulo {
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        let diff = lhs.residue - rhs.residue
        return .init(__unchecked: diff < 0 ? diff + n : diff)
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

// MARK: - Negation

extension Algebra.Z.Modulo {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.negated
    }
}

// MARK: - Multiplication

extension Algebra.Z.Modulo {
    @inlinable
    public static func * (lhs: Self, rhs: Self) throws(Error) -> Self {
        let (product, overflow) = lhs.residue.multipliedReportingOverflow(by: rhs.residue)
        guard !overflow else { throw .arithmetic }
        return .init(__unchecked: product % n)
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) throws(Error) {
        lhs = try lhs * rhs
    }
}
