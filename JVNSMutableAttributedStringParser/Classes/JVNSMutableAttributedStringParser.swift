public extension NSMutableAttributedString {
    
    convenience init(text: String,
                     fontWithoutHTML: UIFont,
                     fontWithHTML: UIFont,
                     htmlOpeningTag: String,
                     htmlClosingTag: String) {
        self.init()
        
        append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : fontWithoutHTML]))
        
        var textCopy = text
        var rangesToDelete = [NSRange]()
        
        while let rangeStart = textCopy.range(of: htmlOpeningTag), let rangeEnd = textCopy.range(of: htmlClosingTag) {
            let subString = textCopy[rangeStart.upperBound..<rangeEnd.lowerBound]
            let attributedString = NSAttributedString(string: String(subString), attributes: [NSAttributedString.Key.font : fontWithHTML])
            let textCopyDistanceStart = textCopy.distance(from: textCopy.startIndex, to: rangeStart.upperBound)
            let textCopyDistanceEnd = textCopy.distance(from: textCopy.startIndex, to: rangeEnd.lowerBound)
            let deletedCharacters = text.count - textCopy.count
            let range = NSRange(location: textCopyDistanceStart + deletedCharacters, length: textCopyDistanceEnd - textCopyDistanceStart)
            
            replaceCharacters(in: range, with: attributedString)
            
            textCopy = String(textCopy.suffix(from: rangeEnd.upperBound))
            
            let rangeToDeleteOpening = NSRange(location: textCopyDistanceStart - htmlOpeningTag.count + deletedCharacters, length: htmlOpeningTag.count)
            let rangeToDeleteClosing = NSRange(location: textCopyDistanceEnd + deletedCharacters, length: htmlClosingTag.count)
            
            rangesToDelete.append(rangeToDeleteOpening)
            rangesToDelete.append(rangeToDeleteClosing)
        }
        
        for range in rangesToDelete.reversed() {
            deleteCharacters(in: range)
        }
    }
}
