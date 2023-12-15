import Foundation
import Sealed
@testable import SealedMacros
import XCTest

final class ParsingTests: XCTestCase {
  let decoder = JSONDecoder()

  func testSealedClassParsing() {
    let json = """
    {
        "type": "LOTTIE",
        "lottieURL": "https://github.com/images"
    }
    """
    let jsonData = Data(json.utf8)
    let imageSource = try? decoder.decode(ImageSource.self, from: jsonData)
    XCTAssertTrue(imageSource != nil)
  }

  func testSealedClassParsing2() {
    let json = """
    {
      "type": "IMAGE",
      "imageURL": "https://github.com/images",
      "imageName": "source"
    }
    """
    let jsonData = Data(json.utf8)
    let imageSource = try? decoder.decode(ImageSource.self, from: jsonData)
    XCTAssertTrue(imageSource != nil)
  }

  func testSealedClassParsing3() {
    let json = """
    {
      "type": "ICON_TYPE",
      "iconURL": "https://github.com/icons"
    }
    """
    let jsonData = Data(json.utf8)
    let imageSource = try? decoder.decode(ImageSource.self, from: jsonData)
    XCTAssertTrue(imageSource != nil)
  }

  func testSealedClassDefault() {
    let json = """
    {
      "type": "unknownCase",
      "iconURL": "https://github.com/icons"
    }
    """
    let jsonData = Data(json.utf8)
    let imageSource = try? decoder.decode(ImageSource.self, from: jsonData)
    XCTAssertTrue(imageSource != nil)
  }
}

@Sealed(typeParseRule: .upperSnakeCase, resilientKey: "unknown")
private enum ImageSource: Decodable {
  case image(Image)
  case lottie(Lottie)
  case iconType(Icon)
  case unknown
}

extension ImageSource {
  struct Image: Codable {
    var imageURL: String
    var imageName: String
  }

  struct Lottie: Codable {
    var lottieURL: String
  }

  struct Icon: Codable {
    var iconURL: String
  }
}
