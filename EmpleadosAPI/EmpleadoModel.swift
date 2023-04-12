//
//  Empleado.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Foundation

// MARK: - Empleado

struct Empleado: Codable, Identifiable, Hashable {
    let id: Int
    let username: String
    let department: Department
    let lastName: String
    let firstName: String
    let zipcode: String
    let gender: Gender
    let address: String
    let email: String
    let avatar: URL

    var fullName: String {
        "\(lastName), \(firstName)"
    }
}

// MARK: - Department

struct Department: Codable, Identifiable, Hashable {
    let name: DepartmentName
    let id: Int
}

enum DepartmentName: String, Codable {
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
}

// MARK: - GenderClass

struct Gender: Codable, Identifiable, Hashable {
    let id: Int
    let gender: GenderName
}

enum GenderName: String, Codable {
    case female = "Female"
    case male = "Male"
}
