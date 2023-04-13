//
//  Prueba.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 12/4/23.
//

import SwiftUI

struct Prueba: View {
    @State private var page = 1
    @State private var data = [String]()

    var body: some View {
//        List(data, id: \.self) { item in
//            Text(item)
//            Text(verbatim: "***pamplona***")
//        }
//        .onAppear {
//            self.loadData($page)
//            self.page += 1
//        }
        VStack(spacing: 0) {
            Image(systemName: "bicycle")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .background {
                    Color(.gray)
                }

            HStack(spacing: 0) {
                Image(systemName: "bicycle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color(.orange)
                    }
                Image(systemName: "bicycle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color(.brown)
                    }
            }
            .frame(maxWidth: .infinity)
        }
    }

    func loadData(_ page: Binding<Int>) {
        let pageLocal = page.wrappedValue

        let newData = (0 * pageLocal ... 29 * pageLocal).map { "\($0)" }
        print(newData)
        data.append(contentsOf: newData)
    }
}

struct Prueba_Previews: PreviewProvider {
    static var previews: some View {
        Prueba()
    }
}
