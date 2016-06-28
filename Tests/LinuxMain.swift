#if os(Linux)

import XCTest
@testable import VaporMustacheTestSuite

XCTMain([
    testCase(ProviderTests.allTests),
])

#endif