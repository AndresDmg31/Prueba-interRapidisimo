//
//
//  TablesModuleViewController.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class TablesModuleViewController: UIViewController {
    
    // MARK: - MVP References
    
    var viewPresenter: TablesModulePresenterProtocol?
    
    // MARK: - UI Elements
    
    /// Arreglo que almacena los datos a mostrar en la tabla.
    private var datos: [CellData] = []
    /// Instancia de UITableView
    private let tableView = UITableView()
    /// Indicador de carga (spinner) que se muestra mientras se realizan operaciones asíncronas como peticiones de red.
    private var loadingIndicator: UIActivityIndicatorView?
    
    // MARK: - Initialization
    
    required init(presenter: TablesModulePresenterProtocol) {
        self.viewPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Agrega el UITableView como subvista del controlador principal.
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(customDataCellTableViewCell.self, forCellReuseIdentifier: customDataCellTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        /// Aplica restricciones constraints al UITableView
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        /// Configura el indicador de carga para ocultarse automáticamente.
        loadingIndicator?.hidesWhenStopped = true
        view.backgroundColor = .white
        viewPresenter?.getTable()
    }
    
}
// MARK: - Implementacion del protocolo de la vista

extension TablesModuleViewController: TablesModuleViewProtocol {
    /// Recibe las tablas desde el Presenter y recarga la tabla en la vista.
    func showTable(_table: [TablaEsquema]) {
        DispatchQueue.main.async {
            self.datos = _table.map { .tabla($0) }
            self.tableView.reloadData()
        }
    }
    /// Muestra un mensaje de error al usuario mediante una alerta.
    func showError(_mensaje: String) {
        func mostrarError(_ mensaje: String) {
            let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alert, animated: true)
        }
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
// MARK: - DataSource para la tabla

extension TablesModuleViewController: UITableViewDataSource {
    /// Devuelve la cantidad de filas que tendra la tabla, basado en el numero de elementos en el arreglo datos.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.count
    }
    /// Devuelve una celda configurada para una fila especifica de la tabla.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customDataCellTableViewCell.identifier, for: indexPath) as? customDataCellTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: datos[indexPath.row])
        return cell
    }
}



