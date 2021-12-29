import UIKit
import Foundation

var components = URLComponents()
components.scheme = "https"
components.host = "kamaal.io"
components.path = "/nearby"
components.queryItems = [URLQueryItem(name: "ll", value: "41.8781,87.6298")]

print(components.url)
