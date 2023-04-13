//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

struct ContentViewIpad: View {
    @EnvironmentObject var vm: EmpleadoVM
    @State var visibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $vm.selectedDpto) {
                ForEach(vm.departamentos) { dpto in
                    Text(dpto.name.rawValue)
                        .tag(dpto)
                }
            }
            .navigationTitle("Departments")
        } content: {
            if let selectedDpto = vm.selectedDpto {
                List(selection: $vm.selected) {
                    ForEach(vm.empleados.filter { $0.department == selectedDpto }) { emp in
                        EmpleadosRow(empleado: emp)
                            .tag(emp)
                    }
                }
                .navigationTitle(selectedDpto.name.rawValue)
            }
        } detail: {
            if let selected = vm.selected {
                DetailView(detailVM: DetailVM(empleado: selected))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            RefreshButton()
                        }
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
        }

        .refreshable {
            vm.loading = true
            await vm.getData()
            vm.loading = false
        }
    }
}

struct ContentViewIpad_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewIpad()
            .environmentObject(EmpleadoVM.test)
    }
}
