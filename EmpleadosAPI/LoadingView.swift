//
//  LoadingView.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 11/4/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack {
                ProgressView()
                    .controlSize(.large)
                Text("Loading...")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
