public extension NSMutableAttributedString {
    
    convenience init(text: String, fontWithoutMarkUp: UIFont, fontWithMarkUp: UIFont, tag: String, argumentsCount: [Int]) {
        self.init()
        
        assert(text.count(occurences: tag).isMultiple(of: 2))
        
        // The initial state is that the whole string is made with the mark up.
        append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : fontWithMarkUp]))
        
        let tagCount = tag.count
        // This is the text that we loop through to find tags
        var textToProcess = text
        
        // Holds the ranges to delete at the very end.
        // These holds the ranges of the tags.
        var rangesToDelete = [NSRange]()
        
        var loopedArgumentsCount = 0
        
        while let start = textToProcess.range(of: tag) {
            if textToProcess.distance(from: textToProcess.startIndex, to: start.lowerBound) != 0 {
                // We arrived at an argument
                textToProcess = String(textToProcess.suffix(textToProcess.count - argumentsCount[loopedArgumentsCount]))
                
                loopedArgumentsCount += 1
            }
            
            // There is a tag to process
            let upperbound = start.upperBound
            let deletedCharacters = text.count - textToProcess.count
            let distanceStart = textToProcess.distance(from: textToProcess.startIndex, to: upperbound)
            
            rangesToDelete.append(NSRange(location: deletedCharacters + distanceStart - tagCount, length: tagCount))
            
            // Remove the opening tag
            textToProcess = String(textToProcess.suffix(from: upperbound))
            
            let endTag = textToProcess.range(of: tag)!
            let distanceEnd = textToProcess.distance(from: textToProcess.startIndex, to: endTag.lowerBound)
            
            rangesToDelete.append(NSRange(location: deletedCharacters + distanceEnd, length: tagCount))
            
            let range = NSRange(location: distanceStart + deletedCharacters, length: distanceEnd - distanceStart)
            let subString = textToProcess[upperbound..<endTag.lowerBound]
            let attributedString = NSAttributedString(string: String(subString), attributes: [NSAttributedString.Key.font : fontWithoutMarkUp])
            
            replaceCharacters(in: range, with: attributedString)
            
            textToProcess = String(textToProcess.suffix(from: endTag.upperBound))
        }
        
        for range in rangesToDelete.reversed() {
            deleteCharacters(in: range)
        }
        
        assert(loopedArgumentsCount == argumentsCount.count)
    }
    
    convenience init(text: String,
                     fontWithoutHTML: UIFont,
                     fontWithHTML: UIFont,
                     htmlOpeningTag: String,
                     htmlClosingTag: String) {
        self.init()
        
        assert(htmlOpeningTag != htmlClosingTag)
        assert(htmlOpeningTag.count > 0 && htmlClosingTag.count > 0)
        assert(text.count(occurences: htmlOpeningTag) == text.count(occurences: htmlClosingTag))
        
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

public extension String {
    /// stringToFind must be at least 1 character.
    /// https://stackoverflow.com/a/45073012/7715250
    func count(occurences: String) -> Int {
        assert(!occurences.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: occurences, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
