//
//  
//  TablesModulePresenter.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class TablesModulePresenter: TablesModulePresenterProtocol {
    // MARK: - Referencias VIPER
    
    var view: TablesModuleViewProtocol?
    var interactor: TablesModuleInteractorProtocol?
    var router: TablesModuleRouterProtocol?
    /// Inicializador que conecta el Presenter con su Interactor y Router
    init(interactor: TablesModuleInteractorProtocol, router:TablesModuleRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }

}
// MARK: - Funciones públicas del Presenter

extension TablesModulePresenter {
    /// Llama al interactor para obtener los datos almacenados en Core Data.
    func getTable() {
        interactor?.getTablesCoredata()
    }
    /// Recibe los datos desde el interactor y los pasa a la vista para que los muestre.
    func tablesObtained(_data: [TablaEsquema]) {
        self.view?.showLoading()
        DispatchQueue.main.async {
            self.view?.hideLoading()
            self.view?.showTable(_table: _data)
        }
    }
    /// Informa a la vista que ocurrio un error al intentar obtener los datos.
    func tablesObtainedError(_mensaje: String) {
        DispatchQueue.main.async {
            self.view?.showError(_mensaje: _mensaje)
        }
    }
}
