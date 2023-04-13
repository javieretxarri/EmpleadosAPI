//
//  DetailVM.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 12/4/23.
//

import SwiftUI

enum DetailFields {
    case firstName, lastName, username, email, address, zipcode

    mutating func next() {
        switch self {
        case .firstName:
            self = .lastName
        case .lastName:
            self = .email
        case .username:
            self = .firstName
        case .email:
            self = .address
        case .address:
            self = .zipcode
        case .zipcode:
            self = .username
        }
    }

    mutating func prev() {
        switch self {
        case .firstName:
            self = .username
        case .lastName:
            self = .firstName
        case .username:
            self = .zipcode
        case .email:
            self = .lastName
        case .address:
            self = .email
        case .zipcode:
            self = .address
        }
    }
}

final class DetailVM: ObservableObject {
    @Published var username: String
    @Published var department: String
    @Published var lastName: String
    @Published var firstName: String
    @Published var zipcode: String
    @Published var gender: String
    @Published var address: String
    @Published var email: String

    var empleado: Empleado

    @Published var errorMsg = ""
    @Published var showAlert = false

    init(empleado: Empleado) {
        self.empleado = empleado
        self.username = empleado.username
        self.department = empleado.department.name.rawValue
        self.lastName = empleado.lastName
        self.firstName = empleado.firstName
        self.zipcode = empleado.zipcode
        self.gender = empleado.gender.gender.rawValue
        self.address = empleado.address
        self.email = empleado.email
    }

    func save() -> Empleados4Update? {
        var msg = ""
        if firstName.isEmpty {
            msg += "The first name cannot be empty\n"
        }

        if lastName.isEmpty {
            msg += "The last name cannot be empty\n"
        }

        if username.isEmpty || username.count < 4 {
            msg += "The username cannot be empty  and the length must be greated thatn 8 characters\n"
        }

        if email.isEmpty || !isValidEmail(email) {
            msg += "The email cannot be empty and it should follow email format\n"
        }

        if msg.isEmpty {
            return Empleados4Update(id: empleado.id, firstName: firstName, lastName: lastName, email: email, username: username, address: address, avatar: empleado.avatar, zipcode: zipcode, department: department, gender: gender)
        } else {
            errorMsg = String(msg.dropLast())
            showAlert.toggle()
        }
        return nil
    }

    func isValidEmail(_ email: String) -> Bool {
        do {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try Regex(emailRegEx)
            return ((try regex.wholeMatch(in: email)) != nil)
        } catch {
            print(error)
        }
        return true
    }
}
