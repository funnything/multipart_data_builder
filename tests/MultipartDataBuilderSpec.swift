import Foundation
import Quick
import Nimble
@testable import MultipartDataBuilder

class MultipartDataBuilderSpec: QuickSpec {

  override func spec() {

    var builder: MultipartDataBuilder!
    beforeEach {
      builder = MultipartDataBuilder()
    }

    it("serializes form field") {
      builder.appendFormData("target", value: "Walter White")
      let wanted = "--\(builder.boundary)\r\n" +
        "Content-Disposition: form-data; name=\"target\"\r\n\r\n" +
        "Walter White\r\n" +
      "--\(builder.boundary)--\r\n"

      expect(builder.build()).to(equal(wanted.dataUsingEncoding(String.Encoding.utf8)!))
    }

    it("serializes multiple form fields") {
      builder.appendFormData("target", value: "Walter White")
      builder.appendFormData("action", value: "kill")

      let wanted = "--\(builder.boundary)\r\n" +
        "Content-Disposition: form-data; name=\"target\"\r\n\r\n" +
        "Walter White\r\n" +
        "--\(builder.boundary)\r\n" +
        "Content-Disposition: form-data; name=\"action\"\r\n\r\n" +
        "kill\r\n" +
      "--\(builder.boundary)--\r\n"

      expect(builder.build()).to(equal(wanted.dataUsingEncoding(String.Encoding.utf8)!))

    }

  }

}
