//
//  
//  TablesModuleProtocols.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

protocol TablesModuleViewProtocol: AnyObject {
	var viewPresenter: TablesModulePresenterProtocol? { get set }
    /// Muestra las tablas obtenidas desde Core Data
    func showTable(_table: [TablaEsquema])
    /// Muestra un mensaje de error en la vista
    func showError(_mensaje: String)
    /// inicia y muestra el spinner de carga.
    func showLoading()
    /// oculta y elimina el spinner de carga.
    func hideLoading()
}

protocol TablesModulePresenterProtocol: AnyObject {
    var view:TablesModuleViewProtocol? { get set }
    var interactor:TablesModuleInteractorProtocol? { get set }
    var router:TablesModuleRouterProtocol? { get set }
    /// Inicia para obtener  las tablas desde el interactor
    func getTable()
    /// Metodo llamado por el interactor cuando las tablas han sido obtenidas correctamente
    func tablesObtained(_data: [TablaEsquema])
    /// Metodo llamado por el interactor cuando ocurre un error al obtener las tablas
    func tablesObtainedError(_mensaje: String)
    
}

protocol TablesModuleInteractorProtocol: AnyObject {
    var presenter:TablesModulePresenterProtocol? { get set }
    /// Obtiene las tablas almacenadas en Core Data
    func getTablesCoredata()
}

protocol TablesModuleRouterProtocol: AnyObject {
    var view: TablesModuleViewProtocol? { get set }
}
