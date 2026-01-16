// Endpoint.swift

/// Position in a sequence: start or end.
///
/// Identifies the beginning or ending position of a sequence, range, or linear
/// structure. Forms a Z₂ group under swap. Use when distinguishing first/last
/// positions in ordered collections.
///
/// ## Example
///
/// ```swift
/// let position: Endpoint = .start
/// print(position.opposite)   // end
/// print(!position)           // end
/// ```
public enum Endpoint: Sendable, Hashable, CaseIterable {
    /// Beginning of the sequence.
    case start

    /// End of the sequence.
    case end
}

// MARK: - Opposite

extension Endpoint {
    /// Opposite endpoint (start↔end).
    @inlinable
    public static func opposite(of endpoint: Endpoint) -> Endpoint {
        switch endpoint {
        case .start: return .end
        case .end: return .start
        }
    }

    /// Opposite endpoint (start↔end).
    @inlinable
    public var opposite: Endpoint {
        Endpoint.opposite(of: self)
    }

    /// Returns the opposite endpoint.
    @inlinable
    public static prefix func ! (value: Endpoint) -> Endpoint {
        value.opposite
    }
}

// MARK: - Aliases

extension Endpoint {
    /// Alias for start.
    public static var first: Endpoint { .start }

    /// Alias for end.
    public static var last: Endpoint { .end }

    /// Alias for start (head of list).
    public static var head: Endpoint { .start }

    /// Alias for end (tail of list).
    public static var tail: Endpoint { .end }
}

// MARK: - Tagged Value

extension Endpoint {
    /// A value paired with its endpoint position.
    public typealias Value<Payload> = Pair<Endpoint, Payload>
}

// MARK: - Finite.Enumerable

extension Endpoint: Finite.Enumerable {
    /// Number of endpoint values.
    @inlinable
    public static var caseCount: Int { 2 }

    /// Index of this value (0: start, 1: end).
    @inlinable
    public var caseIndex: Int {
        switch self {
        case .start: 0
        case .end: 1
        }
    }

    /// Creates a value from its index.
    @inlinable
    public init(caseIndex: Int) {
        self = [.start, .end][caseIndex]
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
extension Endpoint: Codable {}
#endif
