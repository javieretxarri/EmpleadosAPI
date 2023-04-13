//
//  EmpleadosAPIApp.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import SwiftUI

@main
struct EmpleadosAPIApp: App {
    @StateObject var vm = EmpleadoVM()
    @StateObject var monitorNetwork = NetworkStatus()

    var body: some Scene {
        WindowGroup {
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    ContentViewIpad()
                } else {
                    ContentView()
                }
            }
            .environmentObject(vm)
            .overlay {
                if monitorNetwork.status != .online {
                    OfflineView()
                        .transition(.opacity)
                }
            }.overlay {
                ZStack {
                    if vm.loading {
                        LoadingView()
                            .transition(.opacity)
                    }
                }
            }
            .animation(.default, value: vm.loading)
            .animation(.default, value: monitorNetwork.status)
        }
    }
}
