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

class VersionModule {
    
    /// <#Description#>
    /// - Returns: `VersionModuleViewController` Object
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
