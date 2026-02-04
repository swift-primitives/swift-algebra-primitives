// Algebra.Z.Modulo+Arithmetic.swift

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    /// Additive identity.
    @inlinable
    internal static var zero: Self { Self(__unchecked: (), Ordinal(0)) }

    /// Multiplicative identity.
    @inlinable
    internal static var one: Self {
        Self(__unchecked: (), Ordinal(UInt(Tag.capacity > 1 ? 1 : 0)))
    }

    /// Additive inverse.
    @inlinable
    public var negated: Self {
        let a = rawValue.rawValue
        guard a != 0 else { return self }
        return Self(__unchecked: (), Ordinal(UInt(Tag.capacity) - a))
    }
}

// MARK: - Addition

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        let a = lhs.rawValue.rawValue
        let b = rhs.rawValue.rawValue
        let m = UInt(Tag.capacity)
        let sum = a + b
        return Self(__unchecked: (), Ordinal(sum >= m ? sum - m : sum))
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: - Subtraction

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        let a = lhs.rawValue.rawValue
        let b = rhs.rawValue.rawValue
        let result = a >= b ? a - b : UInt(Tag.capacity) - b + a
        return Self(__unchecked: (), Ordinal(result))
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

// MARK: - Negation

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        value.negated
    }
}

// MARK: - Multiplication

extension Tagged where Tag: Algebra.Z.Residual, RawValue == Ordinal {
    @inlinable
    public static func * (lhs: Self, rhs: Self) throws(Error) -> Self {
        let a = lhs.rawValue.rawValue
        let b = rhs.rawValue.rawValue
        let (product, overflow) = a.multipliedReportingOverflow(by: b)
        guard !overflow else { throw .arithmetic }
        return Self(__unchecked: (), Ordinal(product % UInt(Tag.capacity)))
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) throws(Error) {
        lhs = try lhs * rhs
    }
}
