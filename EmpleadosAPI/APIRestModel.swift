//
//  APIRestModel.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Foundation

struct EmpleadosUpdate: Codable {
    let id: Int
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let address: String?
    let avatar: String?
    let zipcode: String?
    let department: Int?
    let gender: Int?
}

struct EmpleadosNew: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let email: String
    let address: String
    let avatar: String?
    let zipcode: String?
    let department: Int
    let gender: Int
}
