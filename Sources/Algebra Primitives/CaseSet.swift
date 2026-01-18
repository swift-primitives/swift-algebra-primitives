// CaseSet.swift
// A collection for tracking enum case occurrences.

/// Tracks occurrences of enum cases with their associated values.
///
/// Unlike a regular `Set`, `CaseSet` can store multiple elements of the same
/// enum case with different associated values. It provides prism-based queries
/// to check for case membership and extract associated values.
///
/// ## Example
///
/// ```swift
/// enum Event: Hashable {
///     case login(userId: Int)
///     case logout(userId: Int)
///     case purchase(itemId: String)
/// }
///
/// extension Event {
///     static var login: Prism<Event, Int> {
///         Prism(
///             embed: { .login(userId: $0) },
///             extract: { if case .login(let id) = $0 { return id } else { return nil } }
///         )
///     }
/// }
///
/// var events: CaseSet<Event> = []
/// events.insert(.login(userId: 1))
/// events.insert(.login(userId: 2))
/// events.insert(.logout(userId: 1))
///
/// events.contains(matching: Event.login)  // true
/// events.values(for: Event.login)         // [1, 2]
/// ```
public struct CaseSet<Element: Hashable & Sendable>: Sendable {
    @usableFromInline
    internal var storage: [Element]

    /// Creates an empty case set.
    @inlinable
    public init() {
        self.storage = []
    }

    /// Creates a case set with the given elements.
    ///
    /// - Parameter elements: The elements to include.
    @inlinable
    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        self.storage = Array(elements)
    }
}

// MARK: - ExpressibleByArrayLiteral

extension CaseSet: ExpressibleByArrayLiteral {
    @inlinable
    public init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

// MARK: - Basic Operations

extension CaseSet {
    /// The number of elements in the set.
    @inlinable
    public var count: Int {
        storage.count
    }

    /// Whether the set is empty.
    @inlinable
    public var isEmpty: Bool {
        storage.isEmpty
    }

    /// Inserts an element into the set.
    ///
    /// - Parameter element: The element to insert.
    @inlinable
    public mutating func insert(_ element: Element) {
        storage.append(element)
    }

    /// Checks if the set contains the given element.
    ///
    /// - Parameter element: The element to check for.
    /// - Returns: `true` if the element is in the set.
    @inlinable
    public func contains(_ element: Element) -> Bool {
        storage.contains(element)
    }

    /// Removes all elements from the set.
    @inlinable
    public mutating func removeAll() {
        storage.removeAll()
    }

    /// Removes the first occurrence of the given element.
    ///
    /// - Parameter element: The element to remove.
    /// - Returns: The removed element, or `nil` if not found.
    @inlinable
    @discardableResult
    public mutating func remove(_ element: Element) -> Element? {
        guard let index = storage.firstIndex(of: element) else { return nil }
        return storage.remove(at: index)
    }
}

// MARK: - Prism-Based Queries

extension CaseSet {
    /// Checks if any element matches the given prism.
    ///
    /// - Parameter prism: The prism to match against.
    /// - Returns: `true` if any element matches the prism.
    @inlinable
    public func contains<Part: Sendable>(matching prism: Optic.Prism<Element, Part>) -> Bool {
        storage.contains { prism.extract($0) != nil }
    }

    /// Extracts all values matching the given prism.
    ///
    /// - Parameter prism: The prism to extract with.
    /// - Returns: A set of all extracted values.
    @inlinable
    public func values<Part: Hashable & Sendable>(for prism: Optic.Prism<Element, Part>) -> Set<Part> {
        Set(storage.compactMap { prism.extract($0) })
    }

    /// Returns all elements matching the given prism.
    ///
    /// - Parameter prism: The prism to match against.
    /// - Returns: An array of matching elements.
    @inlinable
    public func elements<Part: Sendable>(matching prism: Optic.Prism<Element, Part>) -> [Element] {
        storage.filter { prism.extract($0) != nil }
    }

    /// Removes all elements matching the given prism.
    ///
    /// - Parameter prism: The prism to match against.
    /// - Returns: The number of elements removed.
    @inlinable
    @discardableResult
    public mutating func removeAll<Part: Sendable>(matching prism: Optic.Prism<Element, Part>) -> Int {
        let originalCount = storage.count
        storage.removeAll { prism.extract($0) != nil }
        return originalCount - storage.count
    }

    /// Counts elements matching the given prism.
    ///
    /// - Parameter prism: The prism to match against.
    /// - Returns: The number of matching elements.
    @inlinable
    public func count<Part: Sendable>(matching prism: Optic.Prism<Element, Part>) -> Int {
        storage.count { prism.extract($0) != nil }
    }
}

// MARK: - Sequence

extension CaseSet: Sequence {
    @inlinable
    public func makeIterator() -> IndexingIterator<[Element]> {
        storage.makeIterator()
    }
}

// MARK: - Collection

extension CaseSet: Collection {
    public typealias Index = Int

    @inlinable
    public var startIndex: Index { storage.startIndex }

    @inlinable
    public var endIndex: Index { storage.endIndex }

    @inlinable
    public subscript(position: Index) -> Element {
        storage[position]
    }

    @inlinable
    public func index(after i: Index) -> Index {
        storage.index(after: i)
    }
}

// MARK: - Equatable

extension CaseSet: Equatable {
    @inlinable
    public static func == (lhs: CaseSet, rhs: CaseSet) -> Bool {
        lhs.storage == rhs.storage
    }
}

// MARK: - Hashable

extension CaseSet: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(storage)
    }
}
