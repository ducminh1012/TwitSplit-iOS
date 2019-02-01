//
//  SplitMessage.swift
//  TwitSplit-iOS
//
//  Created by MD on 1/31/19.
//  Copyright © 2019 MD. All rights reserved.
//

// Split message into multiple segments with maximum 50 characters including indicator.
func splitMessage(message: String) throws -> [String] {
    
    // Validate empty message
    if let emptyError = validateEmpty(message: message) {
        throw emptyError
    }
    
    // Validate message with word excess max length
    if let excessError = validateWordExcessMaxLength(message: message) {
        throw excessError
    }
    
    // Return message immediately if it's length <= max length
    if (message.count <= kMaxlength) {
        return [message]
    }
    
    // The estimation for segment count
    // We will increase this by 1 each recursion call to find out the exactly number
    let segmentCount = message.count / kMaxlength
    
    return extractWords(message: message, segmentCount: segmentCount)
}

// Loop through message to extract words by length
private func extractWords(message: String, segmentCount: Int) -> [String] {
    
    // Truncate duplicate whitespace and newline character
    var words = message.components(separatedBy: .whitespacesAndNewlines)
    words = words.filter { !$0.isEmpty }
 
    var results: [String] = []
    
    // Store last index where segment's length excess the max length
    var lastIndex = 0
    
    // Loop through the estimation segment count
    for i in 0..<segmentCount {
        
        // The segment indicator with a space suffix
        // Example: "9/10 "
        var indicator = "\(i + 1)/\(segmentCount) "
        
        let nextIndex = lastIndex + (i != 0 && lastIndex < words.count - 1 ? 1 : 0)
        
        // Add words to next segment until excessing the max length
        for index in nextIndex...words.count - 1 {
            
            let word = words[index]
            
            // Break loop if length is over than limit
            // (+ 1 because the last whitespace before trimming)
            let length = indicator.count + word.count
            
            if (length > kMaxlength) {
                break
            }
            
            // Add word to indicator
            indicator += word + " "
            
            // Save the last index for next loop
            lastIndex = index
        }
        
        // Add segment to results
        results.append(indicator.trimmingCharacters(in: .whitespaces))
        
    }
    
    // Call recursion until last index reach the end of words array
    if lastIndex < words.count - 1 {
        
        // Increase segment count by 1
        let total = segmentCount + 1
        results = extractWords(message: message, segmentCount: total)
    }
    
    return results
}
