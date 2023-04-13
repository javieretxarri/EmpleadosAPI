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
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let address: String
    let zipcode: String
    let avatar: URL
    let department: Department
    let gender: Gender

    var fullName: String {
        "\(lastName), \(firstName)"
    }

    var update: EmpleadosUpdate {
        EmpleadosUpdate(id: id,
                        username: username,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        address: address,
                        avatar: avatar.absoluteString,
                        zipcode: zipcode,
                        department: department.id,
                        gender: gender.id)
    }
}

// MARK: - Department

struct Department: Codable, Identifiable, Hashable {
    let id: Int
    let name: DepartmentName
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
