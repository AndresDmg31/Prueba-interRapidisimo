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

///Estructuras para poder convertir los archivos tipo JSON a archivo legible en swift

struct VersionResponse: Codable{
    let versionOfficial: String
}

struct dataAuthRequest: Codable{
    let Mac: String
    let NomAplicacion: String
    let Password: String
    let Path: String
    let Usuario: String
}

struct dataAuthResponse: Codable{
    let Usuario: String
    let Identificacion: String
    let Nombre: String
}

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

