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
    @Published var departamentos: [Department] = []
    @Published var generos: [Gender] = []
    @Published var loading: Bool
    @Published var selectedDpto: Department?
    @Published var selected: Empleado?

    var empleadosDpto: [[Empleado]] {
        Dictionary(grouping: empleados) { empleado in
            empleado.department.name.rawValue
        }.values.sorted { dpto1, dpto2 in
            (dpto1.first?.department.name.rawValue ?? "") <= (dpto2.first?.department.name.rawValue ?? "")
        }
    }

    init(persistence: NetworkPersistence = Persistence.shared) {
        self.persistence = persistence
        self.loading = true
        Task {
            await self.getData()
            await MainActor.run {
                self.loading = false
                self.selectedDpto = departamentos.first
                self.selected = empleados.filter { $0.department == self.selectedDpto }.first
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

    func updateEmpleado(empleado: Empleados4Update) {
        if let index = empleados.firstIndex(where: { $0.id == empleado.id }),
           let dpto = departamentos.first(where: { $0.name.rawValue == empleado.department }),
           let gender = generos.first(where: { $0.gender.rawValue == empleado.gender })
        {
            let new = Empleado(id: empleado.id, firstName: empleado.firstName, lastName: empleado.lastName, username: empleado.username, email: empleado.email, address: empleado.address, zipcode: empleado.zipcode, avatar: empleado.avatar, department: dpto, gender: gender)
            empleados[index] = new
            Task {
                do {
                    try await persistence.putEmpleado(empleado: new)
                } catch {
                    print(error)
                }
            }
        }
    }
}
