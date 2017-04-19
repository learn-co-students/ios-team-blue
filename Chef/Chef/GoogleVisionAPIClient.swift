import Foundation
import SwiftyJSON

final class GoogleVisionAPIClient {

    class func getDescriptionfor(_ content: String, completion: @escaping ([String]) -> ()) {
        print("In googleVision")
        let parameters: [String: Any] = [
            "requests": [
                "image": ["content": content],
                "features": [["type": "DOCUMENT_TEXT_DETECTION", "maxResults": 2]]
            ]
        ]
        guard let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleVisionKey)") else { fatalError("Can't get URL") }

        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            print("Made GV Request!")
        } catch {
            fatalError("Cannot serialize request body")
        }
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            print("Running GV dataTask")
            if let data = data {
                let json = JSON(data: data)
                print("THE JSON IS: \(json)")
                if let description = json["responses"][0]["textAnnotations"][0]["description"].string {
                    print(description)
                    let prettyDescription = self.clean(text: description)
                    print("\n\n")
                    print("----- About to call complection -----")
                    completion(prettyDescription)
                } else {
                    print("Could not read RECEIPT!")
                }
            } else {
                print("Couldn't get data and the error is ", error?.localizedDescription)
            }
        }).resume()
    }

    private static func clean(text: String) -> [String] {
        let nonLetters = ["1", "2", "3", "4", "5","6", "7", "8", "9", "0", ".", ";", ",", "*", "%", "@"]
        let textByLine = text.components(separatedBy: "\n")
        var substanceText: [String] = []

        for line in textByLine {
            var newLine: String = ""

            for char in line.characters {
                if !nonLetters.contains(String(char)) {
                    newLine += String(char)
                }
            }
            if !newLine.isEmpty && newLine.characters.count > 2 {
                substanceText.append(newLine)
            }
        }

        var finalArray: [String] = []
    //This is WIP as we review and collect more receipt data.
        for line in substanceText {
            let simpleLine = line.lowercased()
            if simpleLine.range(of: "refund") != nil ||
                simpleLine.range(of: " tax ") != nil ||
                simpleLine.range(of: "cashier") != nil {
                continue
            } else {
                finalArray.append(line)
            }
        }
        return finalArray
    }
}
