// Polarity.swift

/// Polarity: positive, negative, or neutral.
///
/// Three-valued classification for electric charge, magnetic poles, or electrode
/// designation. Similar to `Sign` but with domain-specific semantics where neutral
/// is distinct from zero magnitude. Use in physics and electrical contexts.
///
/// ## Example
///
/// ```swift
/// let charge: Polarity = .positive
/// print(charge.opposite)     // negative
/// print(charge.isCharged)    // true
/// ```
public enum Polarity: Sendable, Hashable, CaseIterable {
    /// Positive polarity (anode, north-seeking).
    case positive

    /// Negative polarity (cathode, south-seeking).
    case negative

    /// Neutral (no polarity, uncharged).
    case neutral
}

// MARK: - Opposite

extension Polarity {
    /// Opposite polarity (swaps positive↔negative, preserves neutral).
    @inlinable
    public static func opposite(of polarity: Polarity) -> Polarity {
        switch polarity {
        case .positive: return .negative
        case .negative: return .positive
        case .neutral: return .neutral
        }
    }

    /// Opposite polarity (swaps positive↔negative, preserves neutral).
    @inlinable
    public var opposite: Polarity {
        Polarity.opposite(of: self)
    }

    /// Returns the opposite polarity.
    @inlinable
    public static prefix func ! (value: Polarity) -> Polarity {
        value.opposite
    }
}

// MARK: - Properties

extension Polarity {
    /// Whether the polarity is charged (not `.neutral`).
    @inlinable
    public var isCharged: Bool { self != .neutral }

    /// Whether the polarity is `.positive`.
    @inlinable
    public var isPositive: Bool { self == .positive }

    /// Whether the polarity is `.negative`.
    @inlinable
    public var isNegative: Bool { self == .negative }

    /// Whether the polarity is `.neutral`.
    @inlinable
    public var isNeutral: Bool { self == .neutral }
}

// MARK: - Tagged Value

extension Polarity {
    /// A value paired with its polarity.
    public typealias Value<Payload> = Pair<Polarity, Payload>
}

// MARK: - Finite.Enumerable

extension Polarity: Finite.Enumerable {
    /// Number of polarity values.
    @inlinable
    public static var caseCount: Int { 3 }

    /// Index of this value (0: positive, 1: negative, 2: neutral).
    @inlinable
    public var caseIndex: Int {
        switch self {
        case .positive: 0
        case .negative: 1
        case .neutral: 2
        }
    }

    /// Creates a value from its index.
    @inlinable
    public init(caseIndex: Int) {
        self = [.positive, .negative, .neutral][caseIndex]
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
extension Polarity: Codable {}
#endif
