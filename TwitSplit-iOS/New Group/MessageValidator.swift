//
//  MessageValidator.swift
//  TwitSplit-iOS
//
//  Created by MD on 1/31/19.
//  Copyright © 2019 MD. All rights reserved.
//

import Foundation

enum SplitError: Error {
    case inputError(String)
}

// Validate if message is empty
func validateEmpty(message: String) -> SplitError? {
    
    if message.isEmpty {
        return .inputError("Can not split message. Your message is empty.")
    }
    
    return nil
}

// Validate if message have words with have more than 50 characters
func validateWordExcessMaxLength(message: String) -> SplitError? {
    let words = message.components(separatedBy: .whitespaces)
    
    let excessWords = words.filter({$0.count > kMaxlength})
        
    guard excessWords.isEmpty else {
        return .inputError("Can not split message. Your message has one or more words with have more than 50 characters.")
    }
    
    return nil
}
