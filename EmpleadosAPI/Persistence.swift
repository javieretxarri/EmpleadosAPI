//
//  Persistence.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

protocol NetworkPersistence {
    func getEmpleados() async throws -> [Empleado]
    func getGeneros() async throws -> [MaestroGenero]
    func getDepartamentos() async throws -> [MaestroDepartamento]
}

final class Persistence: NetworkPersistence {
    static let shared = Persistence()

    func getEmpleados() async throws -> [Empleado] {
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getEmpleados))
        return try JSONDecoder().decode([Empleado].self, from: data)
    }

    func getGeneros() async throws -> [MaestroGenero] {
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getGeneros))
        return try JSONDecoder().decode([MaestroGenero].self, from: data)
    }

    func getDepartamentos() async throws -> [MaestroDepartamento] {
        let (data, _) = try await URLSession.shared.data(for: .get(url: .getDepartamentos))
        return try JSONDecoder().decode([MaestroDepartamento].self, from: data)
    }
}
