//
//  SplitMessage.swift
//  TwitSplit-iOS
//
//  Created by MD on 1/31/19.
//  Copyright © 2019 MD. All rights reserved.
//

// Split message into multiple segments with maximum 50 characters including indicator.
func splitMessage(message: String) throws -> [String] {
    
    // The estimation for segment count
    // We will increase this by 1 each recursion call to find out the exactly number
    let segmentCount = message.count / kMaxlength

    // Validate empty message
    if let emptyError = validateEmpty(message: message) {
        throw emptyError
    }
    
    // Validate message with word excess max length
    if let excessError = validateWordExcessMaxLength(message: message) {
        throw excessError
    }
    
    let res = extractWords(message: message, segmentCount: segmentCount, limitCharacters: kMaxlength)
    return res
}

// Loop through message to extract words by length
private func extractWords(message: String, segmentCount: Int, limitCharacters: Int) -> [String] {
    
    // Split message into words
    var words = message.components(separatedBy: " ")
    
    // Store last index where segment's length excess the max length
    var lastIndex = 0
    var results = [String]()
    // Loop through all
    for i in 0..<segmentCount {
        
        // The segment indicator with a space suffix
        // Example: "9/10 "
        var indicator = "\(i + 1)/\(segmentCount) "
        
        
        let nextIndex = lastIndex + 1
        
        for index in nextIndex...words.count - 1 {
            let item = words[index]
            
            let length = indicator.count + item.count + 1
            
            if (length > kMaxlength + 1) {
                break
            }
            
            indicator += item + " "
            lastIndex = index
        }
        
        results.append(indicator.trimmingCharacters(in: .whitespaces))
    }
    
    if (lastIndex < words.count - 1) {
        results = extractWords(message: message, segmentCount: segmentCount + 1, limitCharacters: kMaxlength)
    }
    
    return results
    
}
