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
    @FocusState var focusField: DetailFields?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("First Name")
                        .font(.headline)
                    TextField("Enter the first name", text: $detailVM.firstName)
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)
                        .focused($focusField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.headline)
                    TextField("Enter the last name", text: $detailVM.lastName)
                        .textContentType(.familyName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)
                        .focused($focusField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter the email", text: $detailVM.email)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .focused($focusField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }

                Picker(selection: $detailVM.gender) {
                    ForEach(vm.generos) { genero in
                        Text(genero.gender.rawValue)
                            .tag(genero.gender.rawValue)
                    }
                } label: {
                    Text("Gender")
                }

                VStack(alignment: .leading) {
                    Text("Address")
                        .font(.headline)
                    TextField("Enter the Address", text: $detailVM.address)
                        .textContentType(.fullStreetAddress)
                        .textInputAutocapitalization(.words)
                        .focused($focusField, equals: .address)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }

                VStack(alignment: .leading) {
                    Text("Zipcode")
                        .font(.headline)
                    TextField("Enter the Zipcode", text: $detailVM.zipcode)
                        .textContentType(.postalCode)
                        .textInputAutocapitalization(.characters)
                        .focused($focusField, equals: .zipcode)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }

            } header: {
                Text("Personal Data")
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.headline)
                    TextField("Enter the Username", text: $detailVM.username)
                        .textContentType(.username)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                        .keyboardType(.twitter)
                        .focused($focusField, equals: .username)
                        .submitLabel(.next)
                        .onSubmit {
                            focusField?.next()
                        }
                }
                Picker(selection: $detailVM.department) {
                    ForEach(vm.departamentos) { departamento in
                        Text(departamento.name.rawValue)
                            .tag(departamento.name.rawValue)
                    }
                } label: {
                    Text("Departamento")
                }
            } header: {
                Text("User data")
            }
        }
        .textFieldStyle(.roundedBorder)
        .navigationTitle("Edit employee")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Validation erro", isPresented: $detailVM.showAlert) {
            Button("Ok") {}
        } message: {
            Text(detailVM.errorMsg)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    focusField = nil
                    if let save = detailVM.save() {
                        vm.updateEmpleado(empleado: save)
                        dismiss()
                    }
                } label: {
                    Text("Save")
                }
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button {
                        focusField?.prev()
                    } label: {
                        Image(systemName: "chevron.up")
                    }
                    Button {
                        focusField?.next()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    Spacer()
                    Button {
                        focusField = nil
                    } label: {
                        Image(systemName: "keyboard")
                    }
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
