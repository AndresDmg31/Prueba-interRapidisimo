//
//  
//  VersionModule.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import Foundation
import UIKit
/// La class versionmodule se encarga de ensamblar las dependencias (View, Presenter, Interactor, Router)
class VersionModule {
    
        static func build() -> UIViewController {
        let interactor: VersionModuleInteractorProtocol = VersionModuleInteractor()
        let router: VersionModuleRouterProtocol = VersionModuleRouter()
        let presenter: VersionModulePresenterProtocol = VersionModulePresenter(interactor: interactor, router: router)
        let view = VersionModuleViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
