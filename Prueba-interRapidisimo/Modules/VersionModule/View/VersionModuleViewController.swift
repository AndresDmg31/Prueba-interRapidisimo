//
//
//  VersionModuleViewController.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
/// Controlador principal del modulo.
class VersionModuleViewController: UIViewController {
    // MARK: - Properties
    
    var viewPresenter: VersionModulePresenterProtocol?
    var rootView: VersionModuleView?
    
    /// Indicador de carga (spinner) que se muestra mientras se realizan operaciones asincronas como peticiones de red.
    private var loadingIndicator: UIActivityIndicatorView?
    
    // MARK: - Inicializacion
    
    required init(presenter: VersionModulePresenterProtocol) {
        self.viewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Configura el indicador de carga para ocultarse automaticamente.
        loadingIndicator?.hidesWhenStopped = true
        customizeUI()
        configClousers()
        ///Establece la navegacion en el router
        viewPresenter?.router?.navigation = self.navigationController
        view.backgroundColor = .white
        /// Se ejecuta la verificacion de version
        viewPresenter?.verificarVersion()
        /// Se realiza la autenticacion del usuario
        self.viewPresenter?.startAuth()
        /// Se inicia el flujo de carga de datos (tablas)
        self.viewPresenter?.startLoadFlow()
        
        /// Se recuperan los datos del usuario almacenados en UserDefaults
        let nombre = UserDefaults.standard.string(forKey: "nombre") ?? "Usuario"
        let identificacion = UserDefaults.standard.string(forKey: "identificacion") ?? "Usuario"
        let usuario = UserDefaults.standard.string(forKey: "usuario") ?? "Usuario"
        
        
        /// Se actualiza la vista con los datos del usuario
        rootView?.updateData(nombre,identificacion,usuario)
        
    }
    
    // MARK: - UI & Configuración
    
    /// Reemplaza la vista por una personalizada
    func customizeUI() {
        rootView = VersionModuleView()
        view = rootView
    }
    /// Asigna las acciones de los botones de la vista mediante closures
    func configClousers(){
        rootView?.tabGoBoard = {
            self.viewPresenter?.navigateToTables()
        }
        rootView?.tabGoLocal = {
            self.viewPresenter?.navigateToLocal()
        }
    }
}

// MARK: - Implementación del protocolo View

extension VersionModuleViewController: VersionModuleViewProtocol {
    
    /// Muestra una alerta con el mensaje de version recibido del presenter
    func showAlertVersion(mensaje: String) {
        let alert = UIAlertController(title: "Version de la app", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Actualizar", style: .default, handler: { _ in
            if let url = URL(string: "https://apps.apple.com") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Muestra una alerta cuando hay error en la autenticacion o peticiones
    func showAlet(mensaje: String){
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
    /// Muestra un indicador de carga
    func showLoading() {
        DispatchQueue.main.async {
            if self.loadingIndicator == nil {
                let spinner = UIActivityIndicatorView(style: .large)
                spinner.center = self.view.center
                spinner.color = .blue
                spinner.startAnimating()
                spinner.hidesWhenStopped = true
                self.view.addSubview(spinner)
                self.loadingIndicator = spinner
            }
        }
    }
    /// Oculta y elimina el indicador de carga
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator?.stopAnimating()
            self.loadingIndicator?.removeFromSuperview()
            self.loadingIndicator = nil
        }
    }
}
