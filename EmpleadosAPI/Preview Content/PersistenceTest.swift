//
//  PersistenceTest.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Foundation

extension URL {
    static let empleados = Bundle.main.url(forResource: "empleadosTest", withExtension: "json")!
    static let departamentos = Bundle.main.url(forResource: "departamentosTest", withExtension: "json")!
    static let generos = Bundle.main.url(forResource: "generosTest", withExtension: "json")!
}

final class PersistenceTest: NetworkPersistence {
    func getEmpleados() async throws -> [Empleado] {
        let data = try Data(contentsOf: .empleados)
        return try JSONDecoder().decode([Empleado].self, from: data)
    }

    func getGeneros() async throws -> [MaestroGenero] {
        let data = try Data(contentsOf: .generos)
        return try JSONDecoder().decode([MaestroGenero].self, from: data)
    }

    func getDepartamentos() async throws -> [MaestroDepartamento] {
        let data = try Data(contentsOf: .departamentos)
        return try JSONDecoder().decode([MaestroDepartamento].self, from: data)
    }
}

extension EmpleadoVM {
    static let test = EmpleadoVM(persistence: PersistenceTest())
}

extension Empleado {
    static let test = Empleado(id: 21,
                               username: "Bermúdez",
                               department: Department(name: .accounting, id: 1),
                               lastName: "Lastname",
                               firstName: "FirstName",
                               zipcode: "32155",
                               gender: Gender(id: 1, gender: .male),
                               address: "Súper address",
                               email: "uno@gmail.com",
                               avatar: URL(string: "https://robohash.org/voluptatemvoluptatemnon.png")!)
}
