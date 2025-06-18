//
//  
//  LocalModulePresenter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class LocalModulePresenter: LocalModulePresenterProtocol {
    
    var view: LocalModuleViewProtocol?
    var interactor: LocalModuleInteractorProtocol?
    var router: LocalModuleRouterProtocol?
    
    /// Inicializa el presentador con sus dependencias: interactor y router.
    init(interactor: LocalModuleInteractorProtocol, router:LocalModuleRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocalModulePresenter {
    /// Solicita al interactor que obtenga las localidades desde el servicio.
    func getLocal() {
        interactor?.getLocal()
    }
    /// Se ejecuta cuando se reciben correctamente las localidades desde el interactor.
    func locationsObtained(_ data: [locality]) {
        self.view?.showLoading()
        DispatchQueue.main.async {
            self.view?.hideLoading()
            self.view?.showLocalities(data)
        }
    }
    /// Se ejecuta cuando ocurre un error al obtener las localidades.
    func locationsObtainedError(_mensaje: String) {
        view?.showError(_mensaje: _mensaje)
    }
}
