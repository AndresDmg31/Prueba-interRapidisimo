//
//  
//  VersionModuleView.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit
/// Vista principal del modulo.
class VersionModuleView: UIView {
    
    // MARK: - Navegación (Closures de callback)
    /// Callback para navegar al modulo de tablas
    var tabGoBoard: (() -> Void)?
    /// Callback para navegar al modulo de localidades
    var tabGoLocal: (() -> Void)?
    
    // MARK: - UI Components
    /// Creacion de UILabel,Button y stack  para presentar datos en la view principal.

    lazy var stackHome = VersionModuleView.createStackView(axis: .vertical,spacing: 10)
    lazy var title = VersionModuleView.createLabel(text: "Bienvenid@", color: defaultColor, size: 25, weight: .bold)
    lazy var name  = VersionModuleView.createLabel(text: "")
    lazy var id = VersionModuleView.createLabel(text: "")
    lazy var user = VersionModuleView.createLabel(text: "")
    
    lazy var stackButton = VersionModuleView.createStackView(axis: .vertical,spacing: 10)
    lazy var buttonBoard = createCustomButton(title: "Ver Tablas", titleColor: .white, borderColor: defaultColor, backgroundColor: defaultColor, target: self, action: #selector(tabBoard))
    lazy var buttonLocal = createCustomButton(title: "Ver Localidades", titleColor: .white, borderColor: defaultColor, backgroundColor: defaultColor, target: self, action: #selector(tabLocal))

    
    // MARK: - Init
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    
    // MARK: - Layout y estructura visual

    /// Configuracion  de  jerarquía de vistas y constraints usando anclas personalizadas (utils).
    func addViews() {
        
        /// Configuracion de constraints y agregar objetos a la view
        
        stackHome.addArrangedSubview(title)
        stackHome.addArrangedSubview(name)
        stackHome.addArrangedSubview(id)
        stackHome.addArrangedSubview(user)
        stackButton.addArrangedSubview(buttonBoard)
        stackButton.addArrangedSubview(buttonLocal)
        addSubview(stackHome)
        addSubview(stackButton)
        
        stackHome.anchor(
            top: topAnchor, paddingTop: 250,
            leading: leadingAnchor, paddingLeading: 30,
            trailing: trailingAnchor, paddingTrailing: 30
        )
        stackButton.anchor(
            top: stackHome.bottomAnchor, paddingTop: 250,
            leading: leadingAnchor, paddingLeading: 30,
            trailing: trailingAnchor, paddingTrailing: 30
        )
        
        buttonBoard.anchor(height: 45)
        buttonLocal.anchor(height: 45)
    
    }
    
    // MARK: - Acciones

    
    @objc private func tabBoard() {
        tabGoBoard?()
    }
    
    @objc private func tabLocal() {
        tabGoLocal?()
    }
    
    // MARK: - Actualizacion de datos en la vista

    /// Actualiza las etiquetas de datos del usuario
    func updateData(_ nombre: String, _ identificacion: String, _ usuario: String) {
        name.text = "Nombre:   \(nombre)"
        id.text = "Identificacion:   \(identificacion)"
        user.text = "Usuario:   \(usuario)"
    }
}

