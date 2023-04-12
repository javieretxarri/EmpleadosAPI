//
//  EmpleadoVM.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

final class EmpleadoVM: ObservableObject {
    let persistence: NetworkPersistence

    @Published var empleados: [Empleado] = []
    @Published var departamentos: [MaestroDepartamento] = []
    @Published var generos: [MaestroGenero] = []
    @Published var loading: Bool

    init(persistence: NetworkPersistence = Persistence.shared) {
        self.persistence = persistence
        self.loading = true
        Task {
            await self.getData()
            await MainActor.run {
                self.loading = false
            }
        }
    }

    func getData() async {
        do {
            let (empleados, departamentos, generos) = try await (persistence.getEmpleados(), persistence.getDepartamentos(), persistence.getGeneros())

            await MainActor.run {
                (self.empleados, self.departamentos, self.generos) = (empleados, departamentos, generos)
            }

        } catch {
            print(error)
        }
    }

    @MainActor
    func getDataMain() async {
        do {
            async let empleados = persistence.getEmpleados()
            async let departamentos = persistence.getDepartamentos()
            async let generos = persistence.getGeneros()

            (self.empleados, self.departamentos, self.generos) = try await (empleados, departamentos, generos)
        } catch {
            print(error)
        }
    }
}
