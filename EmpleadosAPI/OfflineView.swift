//
//  OfflineView.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 11/4/23.
//

import SwiftUI

struct OfflineView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack {
                Text("No network conection!!")
                    .font(.headline)
                Text("App requires internet conncection to work.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct OfflineView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineView()
    }
}
