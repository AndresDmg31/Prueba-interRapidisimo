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
import CoreData

/// Interactor del modulo que maneja la logica de negocio
class VersionModuleInteractor: VersionModuleInteractorProtocol {
    
    var presenter: VersionModulePresenterProtocol?
}

extension VersionModuleInteractor {
    
    // MARK: - Persistencia
    
    /// Guarda el listado de esquemas de tabla en Core Data.
    /// Antes de guardar, elimina los datos existentes para evitar duplicados.
    func saveDataCoreData(_ modelos: [dataBoard]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        cleanDataTable()

        for modelo in modelos {
            let entidad = TablaEsquema(context: context)
            entidad.nombreTabla = modelo.NombreTabla
            entidad.pk = modelo.Pk
            entidad.queryCreacion = modelo.QueryCreacion
            entidad.batchSize = Int32(modelo.BatchSize)
            entidad.filtro = modelo.Filtro
            entidad.error = modelo.Error
            entidad.numeroCampos = Int32(modelo.NumeroCampos)
            entidad.metodoApp = modelo.MetodoApp

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            formatter.locale = Locale(identifier: "en_US_POSIX")

            if let fecha = formatter.date(from: modelo.FechaActualizacionSincro) {
                entidad.fechaActualizacionSincro = fecha
            } else {
                print("No se pudo parsear la fecha: \(modelo.FechaActualizacionSincro)")
            }
        }

        do {
            try context.save()
            print("Datos guardados en Core Data")
        } catch {
            print("Error al guardar en Core Data: \(error)")
        }
    }
}

/// Elimina todos los registros previos de la entidad  TablaEsquema  en Core Data.
func cleanDataTable() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext

    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TablaEsquema.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
        try context.execute(deleteRequest)
        try context.save()
        print("limpia antes de guardar nuevos datos")
    } catch {
        print("Error al limpiar datos previos: \(error)")
    }
}

extension VersionModuleInteractor {
    
    // MARK: - Servicios REST
    
    /// Realiza una peticion GET para obtener la version actual de la app desde el servidor.
    /// Parameter completion: Devuelve la version remota como String o un Error si falla.
    func fetchRemoteVersion(completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://apitesting.interrapidisimo.co/apicontrollerpruebas/api/ParametrosFramework/ConsultarParametrosFramework/VPStoreAppControl"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL invalida"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Respuesta invalida"])))
                return
            }
                        
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
    
    /// Funcion para Autenticacion, se realiza un POST para obtener autenticacion y datos de usuario
    /// Parameter completion: Devuelve un objeto dataAuthResponse con los datos del usuario o un error.
    func autUser(completion: @escaping (Result<dataAuthResponse, any Error>) -> Void) {
        let urlString = "https://apitesting.interrapidisimo.co/FtEntregaElectronica/MultiCanales/ApiSeguridadPruebas/api/Seguridad/AuthenticaUsuarioApp"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL invalida"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        /// HEADERS
        request.addValue("pam.meredy21", forHTTPHeaderField: "Usuario")
        request.addValue("987204545", forHTTPHeaderField: "Identificacion")
        request.addValue("text/json", forHTTPHeaderField: "Accept")
        request.addValue("pam.meredy21", forHTTPHeaderField: "IdUsuario")
        request.addValue("1295", forHTTPHeaderField: "IdCentroServicio")
        request.addValue("PTO/BOGOTA/CUND/COL/OF PRINCIPAL - CRA 30 # 7-45", forHTTPHeaderField: "NombreCentroServicio")
        request.addValue("9", forHTTPHeaderField: "IdAplicativoOrigen")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body = dataAuthRequest(Mac: "", NomAplicacion: "Controller APP", Password: "SW50ZXIyMDIx\n", Path: "", Usuario: "cGFtLm1lcmVkeTIx\n")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch{
            completion(.failure(error))
            return
        }
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Respuesta invalida"])))
                return
            }
            
            if httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Código HTTP: \(httpResponse.statusCode)"])))
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Sin datos recibidos"])))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(dataAuthResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    /// Realiza una peticion GET para obtener la estructura de las tablas del sistema.
    /// Parameter completion: Informa si la operación fue exitosa o si hubo un error.
    func obtainBoard(completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "https://apitesting.interrapidisimo.co/apicontrollerpruebas/api/SincronizadorDatos/ObtenerEsquema/true"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue("pam.meredy21", forHTTPHeaderField: "Usuario")
        request.addValue("987204545", forHTTPHeaderField: "Identificacion")
        request.addValue("text/json", forHTTPHeaderField: "Accept")
        request.addValue("pam.meredy21", forHTTPHeaderField: "IdUsuario")
        request.addValue("1295", forHTTPHeaderField: "IdCentroServicio")
        request.addValue("PTO/BOGOTA/CUND/COL/OF PRINCIPAL - CRA 30 # 7-45", forHTTPHeaderField: "NombreCentroServicio")
        request.addValue("9", forHTTPHeaderField: "IdAplicativoOrigen")

        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .always
        config.httpShouldSetCookies = true
        config.httpCookieStorage = HTTPCookieStorage.shared
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }


            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Respuesta inválida"])))
                return
            }

            do {
                let resultado = try JSONDecoder().decode([dataBoard].self, from: data)
                self.saveDataCoreData(resultado)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
}
