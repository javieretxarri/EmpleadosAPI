//
//  EmpleadosRow.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 11/4/23.
//

import SwiftUI

struct EmpleadosRow: View {
    let empleado: Empleado

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(empleado.fullName)
                    .font(.headline)
                Text(empleado.email)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(empleado.department.name.rawValue)
                    .font(.caption)
            }
            Spacer()
            AsyncImage(url: empleado.avatar) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(Circle())
            }
        }
    }
}

struct EmpleadosRow_Previews: PreviewProvider {
    static var previews: some View {
        EmpleadosRow(empleado: Empleado.test)
            .frame(width: .infinity, height: 150)
    }
}
