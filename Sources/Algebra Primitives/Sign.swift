// Sign.swift

/// Three-valued sign: positive, negative, or zero.
///
/// Complete numeric classification including zero as a distinct case. Forms a
/// monoid under multiplication with identity `positive` and absorbing element
/// `zero`. Use when working with signed numbers or implementing signum functions.
///
/// ## Example
///
/// ```swift
/// let s = Sign(-5.0)
/// print(s)                       // negative
/// print(s.negated)               // positive
/// print(s.multiplying(.positive)) // negative
/// ```
public enum Sign: Sendable, Hashable, CaseIterable {
    /// Greater than zero.
    case positive

    /// Less than zero.
    case negative

    /// Equal to zero.
    case zero
}

// MARK: - Negation

extension Sign {
    /// Negated sign (swaps positive↔negative, preserves zero).
    @inlinable
    public static func negated(_ sign: Sign) -> Sign {
        switch sign {
        case .positive: return .negative
        case .negative: return .positive
        case .zero: return .zero
        }
    }

    /// Negated sign (swaps positive↔negative, preserves zero).
    @inlinable
    public var negated: Sign {
        Sign.negated(self)
    }

    /// Returns the negated sign.
    @inlinable
    public static prefix func - (value: Sign) -> Sign {
        value.negated
    }
}

// MARK: - Multiplication

extension Sign {
    /// Sign of multiplying two signed values (p×p=p, n×n=p, p×n=n, z×_=z).
    @inlinable
    public static func multiplying(_ lhs: Sign, _ rhs: Sign) -> Sign {
        switch (lhs, rhs) {
        case (.zero, _), (_, .zero): return .zero
        case (.positive, .positive), (.negative, .negative): return .positive
        case (.positive, .negative), (.negative, .positive): return .negative
        }
    }

    /// Sign of multiplying two signed values (p×p=p, n×n=p, p×n=n, z×_=z).
    @inlinable
    public func multiplying(_ other: Sign) -> Sign {
        Sign.multiplying(self, other)
    }
}

// MARK: - Numeric Detection

extension Sign {
    /// Creates a sign from a comparable arithmetic value.
    @inlinable
    public init<T: Comparable & AdditiveArithmetic>(_ value: T) {
        if value > .zero {
            self = .positive
        } else if value < .zero {
            self = .negative
        } else {
            self = .zero
        }
    }
}

// MARK: - Tagged Value

extension Sign {
    /// A value paired with its sign.
    public typealias Value<Payload> = Pair<Sign, Payload>
}

// MARK: - Finite.Enumerable

extension Sign: Finite.Enumerable {
    /// Number of sign values.
    @inlinable
    public static var count: Int { 3 }

    /// Ordinal of this value (0: positive, 1: negative, 2: zero).
    @inlinable
    public var ordinal: Int {
        switch self {
        case .positive: 0
        case .negative: 1
        case .zero: 2
        }
    }

    /// Creates a value from its ordinal.
    @inlinable
    public init(__unchecked: Void, ordinal: Int) {
        self = [.positive, .negative, .zero][ordinal]
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
extension Sign: Codable {}
#endif
