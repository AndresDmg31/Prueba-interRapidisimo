//
//  
//  TablesModuleInteractor.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
import Alamofire
import CoreData

class TablesModuleInteractor: TablesModuleInteractorProtocol {
    /// Referencia al presenter para enviarle los resultados o errores
    var presenter: TablesModulePresenterProtocol?
}

extension TablesModuleInteractor {
    /// Recupera desde Core Data las entidades de tipo TablaEsquema y las envía al presenter.
    func getTablesCoredata (){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TablaEsquema> = TablaEsquema.fetchRequest()
        do {
            let result = try context.fetch(request)
            presenter?.tablesObtained(_data: result)
        } catch {
            presenter?.tablesObtainedError(_mensaje: "Error al leer Core Data: \(error)")
        }
    }
}
