//
//
//  LocalModuleViewController.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class LocalModuleViewController: UIViewController {
    
    var viewPresenter: LocalModulePresenterProtocol?
    
    /// Arreglo con las localidades a mostrar
    private var datos: [CellData] = []
    /// Tabla para mostrar las localidades
    private let tableView = UITableView()
    /// Indicador de carga (spinner) que se muestra mientras se realizan operaciones asíncronas como peticiones de red.
    private var loadingIndicator: UIActivityIndicatorView?
    
    // MARK: - Inicialización del ViewController
    
    required init(presenter: LocalModulePresenterProtocol) {
        self.viewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ciclo de Vida de la Vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Configura el indicador de carga para ocultarse automáticamente.
        tableView.register(customDataCellTableViewCell.self, forCellReuseIdentifier: customDataCellTableViewCell.identifier)
        loadingIndicator?.hidesWhenStopped = true
        setupTableView()
        viewPresenter?.getLocal()
        view.backgroundColor = .white
        
    }
    // MARK: - Configuración de la Tabla
    
    /// Agrega y configura constraints de la tabla
    func setupTableView() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor, bottom: view.bottomAnchor
            )
    }
}
// MARK: - Conformidad con el protocolo de la Vista del Módulo

extension LocalModuleViewController: LocalModuleViewProtocol {
    
    /// Recibe las localidades desde el Presenter y recarga la tabla
    func showLocalities(_ localities: [locality]) {
        DispatchQueue.main.async {
            self.datos = localities.map { .localidad($0) }
            self.tableView.reloadData()
        }
    }
    /// Muestra una alerta de error en caso de falla
    func showError(_mensaje: String) {
        let alert = UIAlertController(title: "Error", message: _mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
// MARK: - Conformidad con el protocolo UITableViewDataSource

extension LocalModuleViewController: UITableViewDataSource {
    /// Número de filas en la tabla según el número de localidades
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.count
    }
    /// Crea y retorna una celda para cada fila de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customDataCellTableViewCell.identifier, for: indexPath) as? customDataCellTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: datos[indexPath.row])
        return cell
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
