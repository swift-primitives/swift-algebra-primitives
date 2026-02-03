import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Endpoint {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Endpoint.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Endpoint.allCases.count == 2)
        #expect(Endpoint.allCases.contains(.start))
        #expect(Endpoint.allCases.contains(.end))
    }

    @Test
    func `opposite swaps values`() {
        #expect(Endpoint.opposite(of: .start) == .end)
        #expect(Endpoint.opposite(of: .end) == .start)
    }

    @Test
    func `opposite property equals static function`() {
        for endpoint in Endpoint.allCases {
            #expect(endpoint.opposite == Endpoint.opposite(of: endpoint))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for endpoint in Endpoint.allCases {
            #expect(!endpoint == endpoint.opposite)
        }
    }

    @Test
    func `aliases are correct`() {
        #expect(Endpoint.first == .start)
        #expect(Endpoint.last == .end)
        #expect(Endpoint.head == .start)
        #expect(Endpoint.tail == .end)
    }

    @Test
    func `Value typealias works`() {
        let paired: Endpoint.Value<String> = .init(.start, "begin")
        #expect(paired.first == .start)
        #expect(paired.second == "begin")
    }
}

// MARK: - EdgeCase

extension Endpoint.Test.EdgeCase {
    @Test
    func `opposite is involution`() {
        for endpoint in Endpoint.allCases {
            #expect(Endpoint.opposite(of: Endpoint.opposite(of: endpoint)) == endpoint)
        }
    }
}
