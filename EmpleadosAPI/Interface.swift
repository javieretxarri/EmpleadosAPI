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

extension URL {
    static let getEmpleados = api.appending(path: "getEmpleados")
    static let getGeneros = api.appending(path: "getGeneros")
    static let getDepartamentos = api.appending(path: "getDepartamentos")
}

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
