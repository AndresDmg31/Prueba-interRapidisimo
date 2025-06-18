//
//  
//  VersionModulePresenter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class VersionModulePresenter: VersionModulePresenterProtocol {
    func navigateToTables() {
        router?.goBoard()
        
    }
    
    func navigateToLocal() {
        router?.goLocal()
        
    }
    
    
    var view: VersionModuleViewProtocol?
    var interactor: VersionModuleInteractorProtocol?
    var router: VersionModuleRouterProtocol?
    
    init(interactor: VersionModuleInteractorProtocol, router:VersionModuleRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Presenter - Private Methods
}

// MARK: - Presenter - Public Methods (Through Protocol)
extension VersionModulePresenter {
    
    ///Funcion para obtener la version local desde el info.plist
    
    func getLocalAppVersion() -> String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    ///Funcion donde comparamos la version local frente a la del servicio
    
    func verificarVersion() {
        interactor?.fetchRemoteVersion { [weak self] (result: Result<String, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let remoteVersion):
                    let localVersion = self.getLocalAppVersion()
                    
                    if localVersion < remoteVersion {
                        self.view?.showAlertVersion(mensaje: "Tu version esta desactualizada (\(localVersion)). Actualiza a la \(remoteVersion).")
                    } else if localVersion > remoteVersion {
                        self.view?.showAlertVersion(mensaje: "Tu version (\(localVersion)) es superior a la oficial (\(remoteVersion)).")
                    }
                case .failure(let error):
                    self.view?.showAlertVersion(mensaje: "Error al verificar version: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func startAuth() {
        interactor?.autUser { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let usuario):
                    UserDefaults.standard.setValue(usuario.Usuario, forKey: "usuario")
                    UserDefaults.standard.setValue(usuario.Identificacion, forKey: "identificacion")
                    UserDefaults.standard.setValue(usuario.Nombre, forKey: "nombre")
                    
                case .failure(let error):
                    self.view?.showAlet(mensaje: "Error de autenticacion: \(error.localizedDescription)")
                }
                
            }
        }
    }
}

