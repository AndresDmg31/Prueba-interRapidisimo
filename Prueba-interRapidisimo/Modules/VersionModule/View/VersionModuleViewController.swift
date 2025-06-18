//
//  
//  VersionModuleViewController.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class VersionModuleViewController: UIViewController {
    
    var viewPresenter: VersionModulePresenterProtocol?
    var rootView: VersionModuleView?
    // MARK: - View - Initialization
    required init(presenter: VersionModulePresenterProtocol) {
        self.viewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        configClousers()
        view.backgroundColor = .white
        //self.viewPresenter?.verificarVersion()
        self.viewPresenter?.startAuth()
        let nombre = UserDefaults.standard.string(forKey: "nombre") ?? "Usuario"
        let identificacion = UserDefaults.standard.string(forKey: "identificacion") ?? "Usuario"
        let usuario = UserDefaults.standard.string(forKey: "usuario") ?? "Usuario"

        rootView?.updateData(nombre,identificacion,usuario)

    }
	
	// MARK: - View - Private Methods
    func customizeUI() {
        rootView = VersionModuleView()
        view = rootView
    }
    
    func configClousers(){
        rootView?.tabGoBoard = {
            self.viewPresenter?.navigateToTables()
        }
        rootView?.tabGoLocal = {
            self.viewPresenter?.navigateToLocal()
        }
    }
}

// MARK: - View - Public Methods (Through Protocol)
extension VersionModuleViewController: VersionModuleViewProtocol {
    
    /// Funcion para mostrar alert referente a la versión que tenemos frente a la que recibimos de servicio
    
    func showAlertVersion(mensaje: String) {
        let alert = UIAlertController(title: "Version de la app", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Funcion para mostrar alert cuando le peticon GET de los datos falla 
    
    func showAlet(mensaje: String){
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                present(alert, animated: true)
    }
}
