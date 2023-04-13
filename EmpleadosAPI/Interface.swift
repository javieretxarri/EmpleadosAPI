//
//  Interface.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Foundation
let prod = URL(string: "https://acacademy-employees-api.herokuapp.com/api")!
let desa = URL(string: "http://localhost:8080/api")!

let api = prod

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension URL {
    static let getEmpleados = api.appending(path: "getEmpleados")
    static let getGeneros = api.appending(path: "getGeneros")
    static let getDepartamentos = api.appending(path: "getDepartamentos")
    static let postEmpleados = api.appending(path: "empleado")
}

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    static func post<JSON: Codable>(url: URL, data: JSON, httpMethod: HTTPMethods = .post) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(data)
        return request
    }
}
