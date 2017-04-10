//
//  GoogleVision.swift
//  Chef
//
//  Created by Kaypree Hodges on 4/4/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import Foundation
import SwiftyJSON

final class GoogleVision {

    class func getDescriptionfor(_ photoURL: String, completion: @escaping (JSON) -> ()) {
        print("In getDescriptionfor")
        let parameters: [String: Any] = [
            "requests": [
                "image": ["source": ["imageUri": photoURL]],
                "features": [["type": "DOCUMENT_TEXT_DETECTION", "maxResults": 2]]
            ]
        ]
        guard let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleVisionKey)") else { fatalError("Can't get URL") }

        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            fatalError("Cannot serialize request body")
        }
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")

        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let json = JSON(data: data)
                let description = json["responses"][0]["textAnnotations"][0]["description"]
                print(description)
                completion(description)
            }
        }).resume()
        
    }


//    class func clean(text: String) -> [String] {
//        let nonLetters = ["1", "2", "3", "4", "5","6", "7", "8", "9", "0", ".", ";", ",", "*", "%", "@"]
//        _ = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
//        let textByLine = text.components(separatedBy: "\n")
//        var substanceText: [String] = []
//
//        /*
//         Get an array of lines form the OCR output
//         For each line, remove any instance of:
//            " tax "
//            "lb"
//            "total tax"
//         For each line determine if:
//            is it empty?
//            does it contain characters?
//            does it contain more than 2 characters?
//        */
//
//        for line in textByLine {
//            var newLine: String = ""
//
//            for char in line.characters {
//                if !nonLetters.contains(String(char)) {
//                    newLine += String(char)
//                }
//            }
//
//            if !newLine.isEmpty && newLine.characters.count > 2 {
//                substanceText.append(newLine)
//            }
//
//
//        }
//
//        return substanceText
//
//    }



//        var lineArray: [String] = []
//        for line in textToClean {
//            var cleanLine = ""
//            let lineChar = line.characters
//            for letter in lineChar {
//                if !nonLetters.contains(String(letter)) {
//                    cleanLine += String(letter)
//                }
//            }
//            lineArray.append(cleanLine)
//        }
//
//        var finalArray: [String] = []
//
//        for line in lineArray {
//            if !line.isEmpty {
//                finalArray.append(line)
//            }
//        }
//
//        print("\n\n\n")
//        print("Clean Array", finalArray)
//
//        return finalArray






//    class func sort(text: String) {
//        let lines = text.components(separatedBy: "\n")
//        var goodLines = [String]()
//        var badLines = [String]()
//        var fixLines = [String]()
//        let nonLetters = ["1", "2", "3", "4", "5","6", "7", "8", "9", "0"]
//
//
//
//        goodLines = lines.filter { (item) -> Bool in
//            var everyCharIsNum = true
//            for char in item.characters {
//                if nonLetters.contains(String(char)) {
//                    continue
//                } else {
//                    everyCharIsNum = false
//                }
//                if !everyCharIsNum {
//                    return item
//                }
//
//
//                print(goodLines)
//
//            }
//
//
////            if !item.contains(item.vowels) || !item.contains(item.consonants) {
////
////            }
//        }
//
//
//    }









}
