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

    func getGeneros() async throws -> [Gender] {
        let data = try Data(contentsOf: .generos)
        let genero = try JSONDecoder().decode([MaestroGenero].self, from: data)
        return genero.compactMap {
            if let gender = GenderName(rawValue: $0.gender) {
                return Gender(id: $0.id, gender: gender)
            } else {
                return nil
            }
        }
    }

    func getDepartamentos() async throws -> [Department] {
        let data = try Data(contentsOf: .departamentos)
        let dptos = try JSONDecoder().decode([MaestroDepartamento].self, from: data)
        return dptos.compactMap {
            if let dpto = DepartmentName(rawValue: $0.name) {
                return Department(id: $0.id, name: dpto)
            } else {
                return nil
            }
        }
    }

    func putEmpleado(empleado: Empleado) async throws {}
}

extension EmpleadoVM {
    static let test = EmpleadoVM(persistence: PersistenceTest())
}

extension Empleado {
    static let test = Empleado(id: 1,
                               firstName: "Julio César",
                               lastName: "Fernández",
                               username: "jcfmunoz",
                               email: "jcfmunoz@icloud.com",
                               address: "Mi casa",
                               zipcode: "28000",
                               avatar: URL(string: "https://pbs.twimg.com/profile_images/1017076264644022272/tetffw3o_400x400.jpg")!,
                               department: Department(id: 1, name: .accounting),
                               gender: Gender(id: 1, gender: .male))
}
