//
//  NetworkStatus.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 11/4/23.
//

import Network
import SwiftUI

// NWPathMonitor

final class NetworkStatus: ObservableObject {
    enum Status {
        case offline, online, unknown
    }

    @Published var status: Status = .unknown

    var monitor: NWPathMonitor
    var queue = DispatchQueue(label: "MonitorNetwork")

    init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}
