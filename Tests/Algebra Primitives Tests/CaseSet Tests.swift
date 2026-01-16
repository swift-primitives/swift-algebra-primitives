// CaseSet Tests.swift

import Testing

@testable import Algebra_Primitives

// MARK: - Test Helpers

enum Event: Hashable, Sendable {
    case login(userId: Int)
    case logout(userId: Int)
    case purchase(itemId: String)
}

extension Event {
    static var login: Prism<Event, Int> {
        Prism(
            embed: { .login(userId: $0) },
            extract: { if case .login(let id) = $0 { return id } else { return nil } }
        )
    }

    static var logout: Prism<Event, Int> {
        Prism(
            embed: { .logout(userId: $0) },
            extract: { if case .logout(let id) = $0 { return id } else { return nil } }
        )
    }

    static var purchase: Prism<Event, String> {
        Prism(
            embed: { .purchase(itemId: $0) },
            extract: { if case .purchase(let id) = $0 { return id } else { return nil } }
        )
    }
}

// MARK: - CaseSet Initialization Tests

@Suite
struct `CaseSet - Initialization` {
    @Test
    func `init creates empty set`() {
        let set = CaseSet<Event>()
        #expect(set.isEmpty)
        #expect(set.count == 0)
    }

    @Test
    func `init from sequence creates set with elements`() {
        let events: [Event] = [.login(userId: 1), .logout(userId: 2)]
        let set = CaseSet(events)
        #expect(set.count == 2)
    }

    @Test
    func `array literal creates set with elements`() {
        let set: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        #expect(set.count == 2)
    }
}

// MARK: - CaseSet Basic Operations Tests

@Suite
struct `CaseSet - Basic Operations` {
    @Test
    func `insert adds element`() {
        var set = CaseSet<Event>()
        set.insert(.login(userId: 1))
        #expect(set.count == 1)
        #expect(set.contains(.login(userId: 1)))
    }

    @Test
    func `insert allows duplicates`() {
        var set = CaseSet<Event>()
        set.insert(.login(userId: 1))
        set.insert(.login(userId: 1))
        #expect(set.count == 2)
    }

    @Test
    func `insert allows same case with different values`() {
        var set = CaseSet<Event>()
        set.insert(.login(userId: 1))
        set.insert(.login(userId: 2))
        #expect(set.count == 2)
    }

    @Test
    func `contains returns true for present element`() {
        let set: CaseSet<Event> = [.login(userId: 1)]
        #expect(set.contains(.login(userId: 1)))
    }

    @Test
    func `contains returns false for absent element`() {
        let set: CaseSet<Event> = [.login(userId: 1)]
        #expect(!set.contains(.login(userId: 2)))
    }

    @Test
    func `remove removes first occurrence`() {
        var set: CaseSet<Event> = [.login(userId: 1), .login(userId: 1)]
        let removed = set.remove(.login(userId: 1))
        #expect(removed == .login(userId: 1))
        #expect(set.count == 1)
    }

    @Test
    func `remove returns nil for absent element`() {
        var set: CaseSet<Event> = [.login(userId: 1)]
        let removed = set.remove(.login(userId: 2))
        #expect(removed == nil)
        #expect(set.count == 1)
    }

    @Test
    func `removeAll clears set`() {
        var set: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        set.removeAll()
        #expect(set.isEmpty)
    }
}

// MARK: - CaseSet Prism-Based Query Tests

@Suite
struct `CaseSet - Prism Queries` {
    @Test
    func `contains matching returns true when case exists`() {
        let set: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        #expect(set.contains(matching: Event.login))
    }

    @Test
    func `contains matching returns false when case absent`() {
        let set: CaseSet<Event> = [.logout(userId: 1)]
        #expect(!set.contains(matching: Event.login))
    }

    @Test
    func `values for prism returns all extracted values`() {
        let set: CaseSet<Event> = [
            .login(userId: 1),
            .login(userId: 2),
            .logout(userId: 3)
        ]
        let loginIds = set.values(for: Event.login)
        #expect(loginIds == [1, 2])
    }

    @Test
    func `values for prism returns empty set when no matches`() {
        let set: CaseSet<Event> = [.logout(userId: 1)]
        let loginIds = set.values(for: Event.login)
        #expect(loginIds.isEmpty)
    }

    @Test
    func `elements matching returns matching elements`() {
        let set: CaseSet<Event> = [
            .login(userId: 1),
            .login(userId: 2),
            .logout(userId: 3)
        ]
        let logins = set.elements(matching: Event.login)
        #expect(logins.count == 2)
        #expect(logins.contains(.login(userId: 1)))
        #expect(logins.contains(.login(userId: 2)))
    }

    @Test
    func `removeAll matching removes matching elements`() {
        var set: CaseSet<Event> = [
            .login(userId: 1),
            .login(userId: 2),
            .logout(userId: 3)
        ]
        let removed = set.removeAll(matching: Event.login)
        #expect(removed == 2)
        #expect(set.count == 1)
        #expect(!set.contains(matching: Event.login))
    }

    @Test
    func `count matching returns correct count`() {
        let set: CaseSet<Event> = [
            .login(userId: 1),
            .login(userId: 2),
            .logout(userId: 3)
        ]
        #expect(set.count(matching: Event.login) == 2)
        #expect(set.count(matching: Event.logout) == 1)
        #expect(set.count(matching: Event.purchase) == 0)
    }
}

// MARK: - CaseSet Collection Conformance Tests

@Suite
struct `CaseSet - Collection` {
    @Test
    func `iteration visits all elements`() {
        let events: [Event] = [.login(userId: 1), .logout(userId: 2)]
        let set = CaseSet(events)
        var visited: [Event] = []
        for event in set {
            visited.append(event)
        }
        #expect(visited == events)
    }

    @Test
    func `subscript returns correct element`() {
        let set: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        #expect(set[0] == .login(userId: 1))
        #expect(set[1] == .logout(userId: 2))
    }

    @Test
    func `startIndex and endIndex are correct`() {
        let set: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        #expect(set.startIndex == 0)
        #expect(set.endIndex == 2)
    }
}

// MARK: - CaseSet Equatable and Hashable Tests

@Suite
struct `CaseSet - Equatable and Hashable` {
    @Test
    func `equal sets are equal`() {
        let set1: CaseSet<Event> = [.login(userId: 1)]
        let set2: CaseSet<Event> = [.login(userId: 1)]
        #expect(set1 == set2)
    }

    @Test
    func `different sets are not equal`() {
        let set1: CaseSet<Event> = [.login(userId: 1)]
        let set2: CaseSet<Event> = [.login(userId: 2)]
        #expect(set1 != set2)
    }

    @Test
    func `order matters for equality`() {
        let set1: CaseSet<Event> = [.login(userId: 1), .logout(userId: 2)]
        let set2: CaseSet<Event> = [.logout(userId: 2), .login(userId: 1)]
        #expect(set1 != set2)
    }

    @Test
    func `equal sets have same hash`() {
        let set1: CaseSet<Event> = [.login(userId: 1)]
        let set2: CaseSet<Event> = [.login(userId: 1)]
        #expect(set1.hashValue == set2.hashValue)
    }
}
