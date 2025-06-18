//
//  
//  LocalModuleProtocols.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

protocol LocalModuleViewProtocol: AnyObject {
	var viewPresenter: LocalModulePresenterProtocol? { get set }
    /// Muestra las localidades obtenidas en pantalla.
    func showLocalities(_ localities: [locality])
    /// Muestra un mensaje de error al usuario.
    func showError(_mensaje: String)
    /// inicia y muestra el spinner de carga.
    func showLoading()
    /// oculta y elimina el spinner de carga.
    func hideLoading()
}

protocol LocalModulePresenterProtocol: AnyObject {
    var view:LocalModuleViewProtocol? { get set }
    var interactor:LocalModuleInteractorProtocol? { get set }
    var router:LocalModuleRouterProtocol? { get set }
    /// Solicita al interactor que obtenga las localidades.
    func getLocal()
    /// Envia al View las localidades recuperadas
    func locationsObtained(_ data: [locality])
    /// Envia al View un mensaje si ocurre un error.
    func locationsObtainedError(_mensaje: String)
}

protocol LocalModuleInteractorProtocol: AnyObject {
    var presenter:LocalModulePresenterProtocol? { get set }
    /// Logica para obtener localidades.
    func getLocal()
}

protocol LocalModuleRouterProtocol: AnyObject {
    var view: LocalModuleViewProtocol? { get set }
}
