#if !canImport(ObjectiveC)
import XCTest

extension JobStorageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobStorageTests = [
        ("testStringRepresentationIsValidJSON", testStringRepresentationIsValidJSON),
    ]
}

extension JobsConfigTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobsConfigTests = [
        ("testAddingAlreadyRegistratedJobsAreIgnored", testAddingAlreadyRegistratedJobsAreIgnored),
        ("testAddingJobs", testAddingJobs),
    ]
}

extension JobsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobsTests = [
        ("testStub", testStub),
    ]
}

extension QueueNameTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__QueueNameTests = [
        ("testKeyIsGeneratedCorrectly", testKeyIsGeneratedCorrectly),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(JobStorageTests.__allTests__JobStorageTests),
        testCase(JobsConfigTests.__allTests__JobsConfigTests),
        testCase(JobsTests.__allTests__JobsTests),
        testCase(QueueNameTests.__allTests__QueueNameTests),
    ]
}
#endif
