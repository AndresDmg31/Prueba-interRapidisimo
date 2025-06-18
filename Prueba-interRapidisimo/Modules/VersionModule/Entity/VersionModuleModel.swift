//
//  
//  VersionModuleModel.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

struct VersionModuleModel {	
}

/// Modelo para respuesta de version del backend.
struct VersionResponse: Codable{
    let versionOfficial: String
}
/// Modelo para los datos enviados en el cuerpo (body) del POST de autenticacion.
struct dataAuthRequest: Codable{
    let Mac: String
    let NomAplicacion: String
    let Password: String
    let Path: String
    let Usuario: String
}
/// Modelo para la respuesta recibida de autenticacion.
/// Contiene la informacion del usuario autenticado.
struct dataAuthResponse: Codable{
    let Usuario: String
    let Identificacion: String
    let Nombre: String
}
/// Modelo para la respuesta que contiene la definición de cada tabla
struct dataBoard: Codable {
    let NombreTabla: String
    let Pk: String
    let QueryCreacion: String
    let BatchSize: Int
    let Filtro: String
    let Error: String?
    let NumeroCampos: Int
    let MetodoApp: String?
    let FechaActualizacionSincro: String
}

