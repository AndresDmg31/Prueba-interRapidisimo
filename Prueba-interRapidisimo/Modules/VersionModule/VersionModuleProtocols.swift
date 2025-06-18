//
//  
//  VersionModuleProtocols.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
/// Protocolo que define las responsabilidades de la Vista en el modulo.
protocol VersionModuleViewProtocol: AnyObject {
	var viewPresenter: VersionModulePresenterProtocol? { get set }
    /// Muestra una alerta relacionada con el control de versiones.
    func showAlertVersion(mensaje: String)
    /// Muestra una alerta generica, por ejemplo, errores de autenticacion.
    func showAlet(mensaje: String)
    /// inicia y muestra el spinner de carga.
    func showLoading()
    /// oculta y elimina el spinner de carga.
    func hideLoading()

}
/// Protocolo que define las responsabilidades del Presenter en el modulo.
protocol VersionModulePresenterProtocol: AnyObject {
    var view:VersionModuleViewProtocol? { get set }
    var interactor:VersionModuleInteractorProtocol? { get set }
    var router:VersionModuleRouterProtocol? { get set }
    /// Verifica la version actual de la aplicacion contra la del servidor.
    func verificarVersion()
    /// Inicia el proceso de autenticacin del usuario.
    func startAuth()
    /// Navega al modulo de tablas.
    func navigateToTables()
    /// Navega al modulo de localidades.
    func navigateToLocal()
    /// Inicia la carga de datos inicial (esquema de tablas).
    func startLoadFlow()



}
/// Protocolo que define las responsabilidades del Interactor en el modulo.
protocol VersionModuleInteractorProtocol: AnyObject {
    var presenter:VersionModulePresenterProtocol? { get set }
    /// Obtiene la version remota desde el backend.
    func fetchRemoteVersion(completion: @escaping (Result<String, Error>) -> Void)
    /// Realiza la autenticacion del usuario.
    func autUser(completion: @escaping(Result<dataAuthResponse, Error>) -> Void)
    /// Obtiene el esquema de tablas desde el backend y las guarda en Core Data.
    func obtainBoard(completion: @escaping (Result<Void, Error>) -> Void)
    

}
/// Protocolo que define las responsabilidades del Router en el modulo de Versión.
protocol VersionModuleRouterProtocol: AnyObject {
    var view: VersionModuleViewProtocol? { get set }
    var navigation: UINavigationController? { get set } 
    /// Redirige al modulo de Tablas.
    func goBoard()
    /// Redirige al modulo de Localidades.
    func goLocal()
}
