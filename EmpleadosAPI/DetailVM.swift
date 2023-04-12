//
//  DetailVM.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 12/4/23.
//

import SwiftUI

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

    func Save() {
        
    }
}
