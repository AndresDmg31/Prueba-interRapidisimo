//
//  
//  VersionModulePresenter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

/// Presenter del modulo  que se encarga de coordinar la logica entre la vista, el interactor y el router.
class VersionModulePresenter: VersionModulePresenterProtocol {
   
    // MARK: - Propiedades

    var view: VersionModuleViewProtocol?
    var interactor: VersionModuleInteractorProtocol?
    var router: VersionModuleRouterProtocol?
    
    // MARK: - Inicializador

    init(interactor: VersionModuleInteractorProtocol, router:VersionModuleRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Navegación

    /// Navega hacia el modulo de tablas.
    func navigateToTables() {
        router?.goBoard()
    }
    
    /// Navega hacia el modulo de localidades.
    func navigateToLocal() {
        router?.goLocal()
    }
    
}

extension VersionModulePresenter {
    
    /// Inicia el flujo de carga inicial llamando al servicio que obtiene las tablas y las guarda en Core Data.
    func startLoadFlow() {
        self.view?.showLoading()
        interactor?.obtainBoard { result in
            DispatchQueue.main.async {
                self.view?.hideLoading()
                
                switch result {
                case .success:
                    print("Datos obtenidos y guardados.")
                case .failure(let error):
                    print("Error al obtener: \(error.localizedDescription)")
                }
            }
        }
    }
    /// Obtiene la version de la app definida en el archivo Info.plist.
    func getLocalAppVersion() -> String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    /// Verifica si la version local de la app es igual, menor o mayor que la version remota obtenida del servidor.
    /// Muestra una alerta en caso de diferencia.
    func verificarVersion() {
        self.view?.showLoading()
        interactor?.fetchRemoteVersion { [weak self] (result: Result<String, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view?.hideLoading()

                switch result {
                case .success(let remoteVersion):
                    let localVersion = self.getLocalAppVersion()
                    
                    if localVersion < remoteVersion {
                        self.view?.showAlertVersion(mensaje: "Tu version esta desactualizada \(localVersion) Actualiza a la \(remoteVersion).")
                    }
                case .failure(let error):
                    self.view?.showAlertVersion(mensaje: "Error al verificar version: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// Inicia el proceso de autenticacion del usuario mediante una peticion POST.
    /// Si la autenticación es exitosa, se almacenan los datos del usuario (nombre, identificacion, usuario) en UserDefaults.
    /// En caso de error, se muestra una alerta con la descripcion del error.
    
    func startAuth() {
        self.view?.showLoading()
        interactor?.autUser { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view?.hideLoading() 

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

