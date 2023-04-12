//
//  DetailView.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 12/4/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm: EmpleadoVM
    @ObservedObject var detailVM: DetailVM

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("First Name")
                        .font(.headline)
                    TextField("Enter the first name", text: $detailVM.firstName)
                }
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.headline)
                    TextField("Enter the last name", text: $detailVM.lastName)
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter the email", text: $detailVM.email)
                }

                Picker(selection: $detailVM.gender) {
                    ForEach(vm.generos) { genero in
                        Text(genero.gender)
                            .tag(genero.gender)
                    }
                } label: {
                    Text("Gender")
                }

                Picker(selection: $detailVM.department) {
                    ForEach(vm.departamentos) { departamento in
                        Text(departamento.name)
                            .tag(departamento.name)
                    }
                } label: {
                    Text("Departamento")
                }

            } header: {
                Text("Employee Data")
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Edit employee")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {} label: {
                    Text("Save")
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(detailVM: DetailVM(empleado: .test))
                .environmentObject(EmpleadoVM.test)
        }
    }
}
