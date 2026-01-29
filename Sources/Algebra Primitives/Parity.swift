// Parity.swift

/// Classification of integers as even or odd.
///
/// Partitions integers into two equivalence classes under modulo 2. Forms a Z₂
/// group under addition (even + even = even, odd + odd = even). Use when tracking
/// divisibility by 2 or implementing parity-based algorithms.
///
/// ## Example
///
/// ```swift
/// let p = Parity(42)
/// print(p)                       // even
/// print(p.adding(.odd))          // odd
/// print(p.multiplying(.odd))     // even
/// ```
public enum Parity: Sendable, Hashable, CaseIterable {
    /// Divisible by 2 (remainder 0).
    case even

    /// Not divisible by 2 (remainder 1).
    case odd
}

// MARK: - Opposite

extension Parity {
    /// Opposite parity (even↔odd).
    @inlinable
    public static func opposite(of parity: Parity) -> Parity {
        switch parity {
        case .even: return .odd
        case .odd: return .even
        }
    }

    /// Opposite parity (even↔odd).
    @inlinable
    public var opposite: Parity {
        Parity.opposite(of: self)
    }

    /// Returns the opposite parity.
    @inlinable
    public static prefix func ! (value: Parity) -> Parity {
        value.opposite
    }
}

// MARK: - Arithmetic Properties

extension Parity {
    /// Parity of adding two values with these parities (e+e=e, o+o=e, e+o=o).
    @inlinable
    public static func adding(_ lhs: Parity, _ rhs: Parity) -> Parity {
        switch (lhs, rhs) {
        case (.even, .even), (.odd, .odd): return .even
        case (.even, .odd), (.odd, .even): return .odd
        }
    }

    /// Parity of adding two values with these parities (e+e=e, o+o=e, e+o=o).
    @inlinable
    public func adding(_ other: Parity) -> Parity {
        Parity.adding(self, other)
    }

    /// Parity of multiplying two values with these parities (o×o=o, else e).
    @inlinable
    public static func multiplying(_ lhs: Parity, _ rhs: Parity) -> Parity {
        switch (lhs, rhs) {
        case (.odd, .odd): return .odd
        default: return .even
        }
    }

    /// Parity of multiplying two values with these parities (o×o=o, else e).
    @inlinable
    public func multiplying(_ other: Parity) -> Parity {
        Parity.multiplying(self, other)
    }
}

// MARK: - Algebraic Identities

extension Parity {
    /// Algebraic identity elements for parity operations.
    public enum identity {
        /// Additive identity: even + x = x.
        @inlinable
        public static var additive: Parity { .even }

        /// Multiplicative identity: odd × x = x.
        @inlinable
        public static var multiplicative: Parity { .odd }
    }
}

// MARK: - Inverse

extension Parity {
    /// Additive inverse (self, since p + p = even in Z₂).
    @inlinable
    public var inverse: Parity { self }
}

// MARK: - Integer Detection

extension Parity {
    /// Determines the parity of an integer.
    @inlinable
    public init<T: BinaryInteger>(_ value: T) {
        self = value.isMultiple(of: 2) ? .even : .odd
    }
}

// MARK: - Tagged Value

extension Parity {
    /// A value paired with its parity.
    public typealias Value<Payload> = Pair<Parity, Payload>
}

// MARK: - Finite.Enumerable

extension Parity: Finite.Enumerable {
    /// Number of parity values.
    @inlinable
    public static var count: Cardinal { 2 }

    /// Ordinal of this value (0: even, 1: odd).
    @inlinable
    public var ordinal: Ordinal {
        switch self {
        case .even: 0
        case .odd: 1
        }
    }

    /// Creates a value from its ordinal.
    @inlinable
    public init(__unchecked: Void, ordinal: Ordinal) {
        self = [.even, .odd][ordinal]
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
extension Parity: Codable {}
#endif
