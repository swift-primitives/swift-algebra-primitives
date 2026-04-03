// Pair Tests.swift

import Testing
import Algebra_Primitives_Test_Support

// MARK: - ~Copyable Test Helper

struct MoveOnly: ~Copyable, Sendable {
    let value: Int
}

// MARK: - Suite Structure

@Suite
struct `Pair Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

// MARK: - Unit: ~Copyable Tier (Static + Consuming)

extension `Pair Tests`.Unit {

    @Test
    func `init with noncopyable values`() {
        let pair = Pair(MoveOnly(value: 1), MoveOnly(value: 2))
        let first = pair.first.value
        let second = pair.second.value
        #expect(first == 1)
        #expect(second == 2)
    }

    @Test
    func `partial consumption of frozen struct`() {
        func consumeBoth(_ pair: consuming Pair<MoveOnly, MoveOnly>) -> (Int, Int) {
            let f = pair.first.value
            let s = pair.second.value
            return (f, s)
        }

        let pair = Pair(MoveOnly(value: 10), MoveOnly(value: 20))
        let (f, s) = consumeBoth(pair)
        #expect(f == 10)
        #expect(s == 20)
    }

    @Test
    func `static map transforms second preserving first`() {
        let pair = Pair(MoveOnly(value: 1), MoveOnly(value: 2))
        let mapped = Pair<MoveOnly, MoveOnly>.map(pair) { MoveOnly(value: $0.value * 10) }
        let first = mapped.first.value
        let second = mapped.second.value
        #expect(first == 1)
        #expect(second == 20)
    }

    @Test
    func `static mapFirst transforms first preserving second`() {
        let pair = Pair(MoveOnly(value: 1), MoveOnly(value: 2))
        let mapped = Pair<MoveOnly, MoveOnly>.mapFirst(pair) { MoveOnly(value: $0.value * 10) }
        let first = mapped.first.value
        let second = mapped.second.value
        #expect(first == 10)
        #expect(second == 2)
    }

    @Test
    func `static bimap transforms both components`() {
        let pair = Pair(MoveOnly(value: 3), MoveOnly(value: 4))
        let mapped = Pair<MoveOnly, MoveOnly>.bimap(
            pair,
            first: { MoveOnly(value: $0.value + 10) },
            second: { MoveOnly(value: $0.value + 20) }
        )
        let first = mapped.first.value
        let second = mapped.second.value
        #expect(first == 13)
        #expect(second == 24)
    }

    @Test
    func `static swapped exchanges components`() {
        let pair = Pair(MoveOnly(value: 1), MoveOnly(value: 2))
        let swapped = Pair<MoveOnly, MoveOnly>.swapped(pair)
        let first = swapped.first.value
        let second = swapped.second.value
        #expect(first == 2)
        #expect(second == 1)
    }

    @Test
    func `consuming swapped instance method`() {
        let pair = Pair(MoveOnly(value: 5), MoveOnly(value: 6))
        let swapped = pair.swapped()
        let first = swapped.first.value
        let second = swapped.second.value
        #expect(first == 6)
        #expect(second == 5)
    }
}

// MARK: - Unit: Copyable Tier (Instance Convenience)

extension `Pair Tests`.Unit {

    @Test
    func `instance map transforms second`() {
        let pair = Pair(1, 2)
        let mapped = pair.map { $0 * 10 }
        #expect(mapped.first == 1)
        #expect(mapped.second == 20)
    }

    @Test
    func `instance mapSecond transforms second`() {
        let pair = Pair("hello", 3)
        let mapped = pair.mapSecond { $0 + 7 }
        #expect(mapped.first == "hello")
        #expect(mapped.second == 10)
    }

    @Test
    func `instance mapFirst transforms first`() {
        let pair = Pair(1, "world")
        let mapped = pair.mapFirst { $0 * 5 }
        #expect(mapped.first == 5)
        #expect(mapped.second == "world")
    }

    @Test
    func `instance bimap transforms both`() {
        let pair = Pair(2, 3)
        let mapped = pair.bimap(first: { $0 * 10 }, second: { $0 * 100 })
        #expect(mapped.first == 20)
        #expect(mapped.second == 300)
    }

    @Test
    func `consuming swapped on copyable pair`() {
        let pair = Pair(1, 2)
        let swapped = pair.swapped()
        #expect(swapped.first == 2)
        #expect(swapped.second == 1)
    }
}

// MARK: - Unit: Tuple Conversion

extension `Pair Tests`.Unit {

    @Test
    func `init from tuple`() {
        let pair = Pair((10, 20))
        #expect(pair.first == 10)
        #expect(pair.second == 20)
    }

    @Test
    func `tuple property round-trips`() {
        let pair = Pair(3, 4)
        let tuple = pair.tuple
        #expect(tuple.0 == 3)
        #expect(tuple.1 == 4)
    }
}

// MARK: - Unit: Equatable and Hashable

extension `Pair Tests`.Unit {

    @Test
    func `equatable conformance`() {
        let a = Pair(1, 2)
        let b = Pair(1, 2)
        let c = Pair(1, 3)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `hashable conformance`() {
        let a = Pair(1, 2)
        let b = Pair(1, 2)
        #expect(a.hashValue == b.hashValue)
    }
}

// MARK: - Unit: CaseIterable

extension `Pair Tests`.Unit {

    enum Direction: CaseIterable { case left, right }

    @Test
    func `allFirsts returns all cases`() {
        let cases = Pair<Direction, Int>.allFirsts
        #expect(cases.count == 2)
    }
}

// MARK: - Unit: Sendable

extension `Pair Tests`.Unit {

    @Test
    func `noncopyable sendable pair satisfies Sendable`() {
        func assertSendable<T: Sendable & ~Copyable>(_: borrowing T) {}
        let pair = Pair(MoveOnly(value: 42), MoveOnly(value: 99))
        assertSendable(pair)
    }

    @Test
    func `copyable sendable pair satisfies Sendable`() async {
        let pair = Pair(42, 99)
        let result = await Task { pair.first + pair.second }.value
        #expect(result == 141)
    }
}

// MARK: - Edge Cases

extension `Pair Tests`.`Edge Case` {

    @Test
    func `map with identity preserves value`() {
        let pair = Pair(MoveOnly(value: 7), MoveOnly(value: 8))
        let mapped = Pair<MoveOnly, MoveOnly>.map(pair) { $0 }
        let second = mapped.second.value
        #expect(second == 8)
    }

    @Test
    func `double swap is identity`() {
        let pair = Pair(MoveOnly(value: 1), MoveOnly(value: 2))
        let once = Pair<MoveOnly, MoveOnly>.swapped(pair)
        let twice = Pair<MoveOnly, MoveOnly>.swapped(once)
        let first = twice.first.value
        let second = twice.second.value
        #expect(first == 1)
        #expect(second == 2)
    }

    @Test
    func `map with throwing transform propagates error`() {
        struct Fail: Error, Equatable {}
        let pair = Pair(1, 2)
        do {
            _ = try pair.map { _ throws(Fail) -> Int in throw Fail() }
            Issue.record("Expected Fail to be thrown")
        } catch {
            #expect(error == Fail())
        }
    }

    @Test
    func `bimap with throwing transform propagates error`() {
        struct Fail: Error, Equatable {}
        let pair = Pair(1, 2)
        do {
            _ = try pair.bimap(
                first: { (x: Int) throws(Fail) -> Int in x },
                second: { _ throws(Fail) -> Int in throw Fail() }
            )
            Issue.record("Expected Fail to be thrown")
        } catch {
            #expect(error == Fail())
        }
    }
}
