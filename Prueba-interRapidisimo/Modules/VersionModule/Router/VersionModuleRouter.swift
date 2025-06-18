//
//  
//  VersionModuleRouter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class VersionModuleRouter: VersionModuleRouterProtocol {
    func goBoard() {
       /* let tablasVC = TablasModule.build()
                view?.navigationController?.pushViewController(tablasVC, animated: true)*/
    }
    
    func goLocal() {
       /* let localidadesVC = LocalidadesModule.build()
                view?.navigationController?.pushViewController(localidadesVC, animated: true)*/
    }
    
	weak var view: VersionModuleViewProtocol?
    
	// MARK: - Router - Private Methods
}

// MARK: - Router - Public Methods (Through Protocol)
extension VersionModuleRouter {
}
