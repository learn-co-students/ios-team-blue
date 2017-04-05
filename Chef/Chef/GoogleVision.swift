//
//  GoogleVision.swift
//  Chef
//
//  Created by Kaypree Hodges on 4/4/17.
//  Copyright © 2017 Blue Team. All rights reserved.
//

import Foundation

final class GoogleVision {

    class func getDescriptionfor(_ photoURL: String) {
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

                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                if let unwJson = json {
//                    print("JSON", json)
                    let textAnnotations = unwJson?["responses"] as? [[String: String]]
                    if let unwTextAnnotations = textAnnotations {
                    print("ANNOTATIONS:", unwTextAnnotations)
//                    let annotations = unwResponses[0] as [String: String]
//                    print("The annotations in getDescriptionFor are", annotations)
                    } else {
                        print("Can't get textAnnotations")
                    }
                }
            }
        }).resume()
        
    }
    
}
