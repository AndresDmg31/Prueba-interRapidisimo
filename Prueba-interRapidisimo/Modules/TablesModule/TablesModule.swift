//
//  
//  TablesModule.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import Foundation
import UIKit

class TablesModule {
    
        static func build() -> UIViewController {
        let interactor: TablesModuleInteractorProtocol = TablesModuleInteractor()
        let router: TablesModuleRouterProtocol = TablesModuleRouter()
        let presenter: TablesModulePresenterProtocol = TablesModulePresenter(interactor: interactor, router: router)
        let view = TablesModuleViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
