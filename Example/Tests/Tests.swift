import XCTest
import JVNSMutableAttributedStringParser

class NSMutableAttributedStringHTMLTagFormatterTests: XCTestCase {
    
    fileprivate static let fontWithoutHTML = UIFont.systemFont(ofSize: 10, weight: .thin)
    fileprivate static let fontWithHTML = UIFont.systemFont(ofSize: 10, weight: .thin)
    
    func testNoTag() {
        let someString = "This is some string"
        let transformedString0 = NSMutableAttributedString(text: someString, openingTag: "<p>", closingTag: "</p>")
        
        XCTAssert(someString.count == transformedString0.string.count)
        
        let transformedString1 = NSMutableAttributedString(text: someString, openingTag: "<b>", closingTag: "</b>")
        
        XCTAssert(someString.count == transformedString1.string.count)
    }
    
    func testTag() {
        let someString = "<b>This</b> is some string"
        
        let transformedString0 = NSMutableAttributedString(text: someString, openingTag: "<o>", closingTag: "</o>")
        
        XCTAssert(someString.count == transformedString0.string.count)
        
        let transformedString1 = NSMutableAttributedString(text: someString, openingTag: "<b>", closingTag: "</b>")
        
        XCTAssert(someString.count - 7 == transformedString1.string.count)
    }
    
    func testMultipleTags() {
        let someString = "<b>This</b> is <b>some</b> string"
        
        let transformedString0 = NSMutableAttributedString(text: someString, openingTag: "<o>", closingTag: "</o>")
        
        XCTAssert(someString.count == transformedString0.string.count)
        
        let transformedString1 = NSMutableAttributedString(text: someString, openingTag: "<b>", closingTag: "</b>")
        
        XCTAssert(someString.count - 14 == transformedString1.string.count)
    }
    
    func testMultipleTags2() {
        let someString = "<b>This</b> is <b>some</b> string<b>.</b>"
        
        let transformedString0 = NSMutableAttributedString(text: someString, openingTag: "<o>", closingTag: "</o>")
        
        XCTAssert(someString.count == transformedString0.string.count)
        
        let transformedString1 = NSMutableAttributedString(text: someString, openingTag: "<b>", closingTag: "</b>")
        
        XCTAssert(someString.count - 21 == transformedString1.string.count)
    }
    
    func testMultipleTags3() {
        let someString = "<b>This</b> is <o>some</o> string<b>.</b>"
        
        let transformedString0 = NSMutableAttributedString(text: someString, openingTag: "<p>", closingTag: "</p>")
        
        XCTAssert(someString.count == transformedString0.string.count)
        
        let transformedString1 = NSMutableAttributedString(text: someString, openingTag: "<b>", closingTag: "</b>")
        
        XCTAssert(someString.count - 14 == transformedString1.string.count)
    }
    
    func testPerformance() {
        self.measure {
            _ = NSMutableAttributedString(text: "<b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b>, <b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b>, <b> asdda </b> <b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b> <b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
            _ = NSMutableAttributedString(text: "<b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b><b> asdda </b>", fontWithoutHTML: .systemFont(ofSize: 10, weight: .thin), fontWithHTML: .italicSystemFont(ofSize: 40), htmlOpeningTag: "<b>", htmlClosingTag: "</b>")
        }
    }
}

fileprivate extension NSMutableAttributedString {
    convenience init(text: String, openingTag: String, closingTag: String) {
        self.init(text: text, fontWithoutHTML: NSMutableAttributedStringHTMLTagFormatterTests.fontWithoutHTML, fontWithHTML: NSMutableAttributedStringHTMLTagFormatterTests.fontWithHTML, htmlOpeningTag: openingTag, htmlClosingTag: closingTag)
    }
}
