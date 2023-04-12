//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: EmpleadoVM

    var body: some View {
        NavigationStack {
            List(vm.empleados) { empleado in
                NavigationLink(value: empleado) {
                    EmpleadosRow(empleado: empleado)
                }
            }
            .navigationTitle("Empleados")
            .navigationDestination(for: Empleado.self) { empleado in
                DetailView(detailVM: DetailVM(empleado: empleado))
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        vm.loading = true
                        Task {
                            try await Task.sleep(for: .seconds(2))
                            await MainActor.run {
                                vm.loading = false
                            }
                        }

                    } label: {
                        Text("Carga")
                    }
                }
            }
        }
        .refreshable {
            vm.loading = true
            await vm.getData()
            vm.loading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EmpleadoVM.test)
    }
}
