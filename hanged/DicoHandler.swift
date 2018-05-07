//
//  DicoHandler.swift
//  hanged
//
//  Created by Juan Barragan on 03/05/2018.
//  Copyright © 2018 Juan Barragan. All rights reserved.
//

import Foundation
class DicoHandler
{
    var words: [String]?
    static let instance = DicoHandler()
    
    private init() {
        if let path = Bundle.main.path(forResource: "wclean", ofType: "txt") {
            let data = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
            words = data?.components(separatedBy: NSCharacterSet.newlines)
        } else {
            print ("Word File not found")
        }
        
        // calculate first frequency
    }
    
    static func getInstance() -> DicoHandler {
        return instance
    }
    
    func start(withNumber: Int) -> [String] {
        return filter(forWords: getInitialWords(), bySize: withNumber)
    }
    
    func getInitialWords() -> [String] {
        return words!
    }
    
    func getMostCommunLetter(inTheseWords: [String], alreadySeen: Set<Character>)-> Character {
        let frequencies = getLetterFrequencies(forWordList: inTheseWords)
        let dicoFrequencies = frequencies.sorted(by: {$0.value > $1.value})
        for pair in dicoFrequencies {
            if !alreadySeen.contains(pair.key) {
                return pair.key
            }
        }
        return Character("?")
    }
    
    // Returns words not containing the given letter
    func filter(forWords: [String], without: Character) -> [String] {
        var answer = [String]()
        for word in forWords {
            if !word.contains(without) {
                answer.append(word)
            }
        }
        return answer
    }
    
    // returns a list of words containing the chars at the given positions
    func filter(forWords: [String], withChar: Character, inPosition: [Int]) -> [String] {
        var answer = [String]()
        for word in forWords {
            var match = true
            for position in inPosition {
                let index = word.index(word.startIndex, offsetBy: position)
                match = match && (word[index] == withChar)
                if !match {
                    continue
                }
            }
            if match {
                answer.append(word)
            }
        }
        
        return answer
    }
    func filter(forWords: [String], bySize: Int) -> [String] {
        var answer = [String]()
        for word in forWords {
            if word.count == bySize {
                answer.append(word)
            }
        }
        
        return answer
    }
    
    
    func getLetterFrequencies(forWordList: [String]) -> [Character:Float] {
        var answer = [Character:Float]()
        var letters = Set<Character>()
        for word in forWordList {
            for char in word {
                if (answer[char] != nil) {
                    answer[char]! += 1
                } else {
                    answer[char] = 1
                }
                letters.insert(char)
            }
        }
        let numLetters = letters.count
        for (char, frequency) in answer {
            answer[char] = frequency/Float(numLetters)
        }
        
        return answer
    }
}
