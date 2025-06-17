//
//  
//  VersionModuleInteractor.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
import Alamofire

class VersionModuleInteractor: VersionModuleInteractorProtocol {
    var presenter: VersionModulePresenterProtocol?
	// MARK: - Interactor - Private Methods
}

// MARK: - Interactor - Public Methods (Through Protocol)
extension VersionModuleInteractor {
    
    ///Realiza la peticion GET con URLSession  para obtener la versión
    
    func fetchRemoteVersion(completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://apitesting.interrapidisimo.co/apicontrollerpruebas/api/ParametrosFramework/ConsultarParametrosFramework/VPStoreAppControl"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL invalida"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            ///Validamos errores en la red
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            /// Validamos que la respuesta sea valida y el status sea 200

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Respuesta invalida"])))
                return
            }
            
            ///Se codifica la version para poderla leer en nuestro formato
            
            do {
                let decoder = JSONDecoder()
                let remoteVersion = try JSONDecoder().decode(String.self, from: data)
                completion(.success(remoteVersion))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
