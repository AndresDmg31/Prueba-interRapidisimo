//
//  
//  LocalModule.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import Foundation
import UIKit

class LocalModule {
    
        static func build() -> UIViewController {
        let interactor: LocalModuleInteractorProtocol = LocalModuleInteractor()
        let router: LocalModuleRouterProtocol = LocalModuleRouter()
        let presenter: LocalModulePresenterProtocol = LocalModulePresenter(interactor: interactor, router: router)
        let view = LocalModuleViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
