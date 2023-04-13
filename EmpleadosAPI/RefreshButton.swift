//
//  RefreshButton.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 13/4/23.
//

import SwiftUI

struct RefreshButton: View {
    @Environment(\.refresh) private var refresh

    var body: some View {
        Button {
            Task { await refresh?() }
        } label: {
            Image(systemName: "arrow.clockwise")
        }
        .disabled(refresh == nil)
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton()
    }
}
