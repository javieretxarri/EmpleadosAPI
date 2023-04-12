//
//  EmpleadoCombineVM.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Combine
import SwiftUI

final class EmpleadoCVM: ObservableObject {
    let persistence = PersistenceCombine.shared

    var subscribers = Set<AnyCancellable>()

    @Published var empleados: [Empleado] = []
    @Published var departamentos: [MaestroDepartamento] = []
    @Published var generos: [MaestroGenero] = []

    init() {
        getDataSink()
    }

    func getEmpleadosClean() {
        persistence.getEmpleados { error in
            print(error)
        } value: { empleados in
            self.empleados = empleados
        }
        .store(in: &subscribers)
    }

    func getEmpleadosSink() {
        persistence.getEmpleados()
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { empleados in
                self.empleados = empleados
            }
            .store(in: &subscribers)
    }

    func getDataSink() {
        Publishers.Zip3(persistence.getEmpleados(), persistence.getGeneros(), persistence.getDepartamentos())
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { empleados, generos, departamentos in
                self.empleados = empleados
                self.generos = generos
                self.departamentos = departamentos
            }
            .store(in: &subscribers)
    }
}
