//
//  
//  VersionModuleRouter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
/// Router del modulo se encarga de la navegacion hacia otros modulos de la app .
class VersionModuleRouter: VersionModuleRouterProtocol {
    var navigation: UINavigationController?
    weak var viewController: UIViewController?
    
    /// Función que navega hacia el modulo de visualizacion de tablas.
    func goBoard() {
        let tablesVC = TablesModule.build()
        navigation?.pushViewController(tablesVC, animated: true)
    }
    /// Funcion que navega hacia el modulo de visualizacion de localidades.
    func goLocal() {
        let localVC = LocalModule.build()
        navigation?.pushViewController(localVC, animated: true)
    }
	weak var view: VersionModuleViewProtocol?
}

extension VersionModuleRouter {
}
