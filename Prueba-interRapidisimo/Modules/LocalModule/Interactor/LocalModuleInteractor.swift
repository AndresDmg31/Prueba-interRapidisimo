//
//  
//  LocalModuleInteractor.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
import Alamofire

class LocalModuleInteractor: LocalModuleInteractorProtocol {
    var presenter: LocalModulePresenterProtocol?
}

extension LocalModuleInteractor {
    /// Realiza una petición GET para obtener las localidades.
    func getLocal() {
        let urlString = "https://apitesting.interrapidisimo.co/apicontrollerpruebas/api/ParametrosFramework/ObtenerLocalidadesRecogidas"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                self.presenter?.locationsObtainedError(_mensaje: error.localizedDescription)
                return
            }
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                self.presenter?.locationsObtainedError(_mensaje: "Respuesta invalida")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([locality].self, from: data)
                self.presenter?.locationsObtained(result)
            } catch {
                self.presenter?.locationsObtainedError(_mensaje: "Error al decodificar : \(error)")
            }
        }
        
        task.resume()
    }
}
