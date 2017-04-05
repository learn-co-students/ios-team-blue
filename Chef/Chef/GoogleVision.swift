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
                let json = JSON(data: data)
                let text = json["responses"][0]["textAnnotations"][0]["description"]
                print(text)

            }
        }).resume()
        
    }
    
}

