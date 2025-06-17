//
//  
//  VersionModuleProtocols.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

protocol VersionModuleViewProtocol: AnyObject {
	var viewPresenter: VersionModulePresenterProtocol? { get set }
    func mostrarAlertaVersion(mensaje: String)

}

protocol VersionModulePresenterProtocol: AnyObject {
    var view:VersionModuleViewProtocol? { get set }
    var interactor:VersionModuleInteractorProtocol? { get set }
    var router:VersionModuleRouterProtocol? { get set }
    func verificarVersion()

}

protocol VersionModuleInteractorProtocol: AnyObject {
    var presenter:VersionModulePresenterProtocol? { get set }
    func fetchRemoteVersion(completion: @escaping (Result<String, Error>) -> Void)
    

}

protocol VersionModuleRouterProtocol: AnyObject {
    var view: VersionModuleViewProtocol? { get set }
}
