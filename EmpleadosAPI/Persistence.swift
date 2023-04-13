//
//  Persistence.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

protocol NetworkPersistence {
    func getEmpleados() async throws -> [Empleado]
    func getGeneros() async throws -> [Gender]
    func getDepartamentos() async throws -> [Department]
    func putEmpleado(empleado: Empleado) async throws
}

final class Persistence: NetworkPersistence {
    static let shared = Persistence()

    func getEmpleados() async throws -> [Empleado] {
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getEmpleados))
        let empleadosTmp = try JSONDecoder().decode([Empleado].self, from: data)
        return empleadosTmp.sorted { $0.id < $1.id }
    }

    func getGeneros() async throws -> [Gender] {
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getGeneros))
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
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getDepartamentos))
        let dptos = try JSONDecoder().decode([MaestroDepartamento].self, from: data)
        return dptos.compactMap {
            if let dpto = DepartmentName(rawValue: $0.name) {
                return Department(id: $0.id, name: dpto)
            } else {
                return nil
            }
        }
    }

    func putEmpleado(empleado: Empleado) async throws {
        let (_, response) = try await URLSession.shared.data(for: .post(url: .postEmpleados, data: empleado.update, httpMethod: .put))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
