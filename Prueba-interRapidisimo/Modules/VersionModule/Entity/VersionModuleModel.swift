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

//Estructura para poder convertir el archivo tipo JSON a archivo legible en swift

struct VersionResponse: Codable{
    let versionOfficial: String
}
