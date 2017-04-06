import Foundation

enum SpoonacularAPIClientResponse {
    case success(Any)
    case failure(SpoonacularAPIClientError)
}

enum SpoonacularAPIClientError: Error {
    case nodata
}
