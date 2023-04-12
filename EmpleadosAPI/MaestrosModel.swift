//
//  MaestrosModel.swift
//  EmpleadosAPI
//
//  Created by Javier Etxarri on 10/4/23.
//

import Foundation

// MARK: - MaestroDepartamento

struct MaestroDepartamento: Codable, Identifiable {
    let id: Int
    let name: String
}

// MARK: - MaestroGenero

struct MaestroGenero: Codable, Identifiable {
    let id: Int
    let gender: String
}
