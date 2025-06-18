//
//  cellDataEnum.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 18/06/25.
//

import Foundation
/// Este enum permite manejar diferentes tipos de datos (TablaEsquema y locality)
enum CellData {
    case tabla(TablaEsquema)
    case localidad(locality)
}
