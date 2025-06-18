//
//  
//  VersionModuleView.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//
//

import UIKit

class VersionModuleView: UIView {
    
    var tabGoBoard: (() -> Void)?
    var tabGoLocal: (() -> Void)?
    
    /// Creacion de UILabel y Button para presentar datos en la view principal

    lazy var stackHome = VersionModuleView.createStackView(axis: .vertical,spacing: 10)
    lazy var title = VersionModuleView.createLabel(text: "Bienvenid@", color: defaultColor, size: 25, weight: .bold)
    lazy var name  = VersionModuleView.createLabel(text: "")
    lazy var id = VersionModuleView.createLabel(text: "")
    lazy var user = VersionModuleView.createLabel(text: "")
    
    lazy var stackButton = VersionModuleView.createStackView(axis: .vertical,spacing: 10)
    lazy var buttonBoard = createCustomButton(title: "Ver Tablas", titleColor: .white, borderColor: defaultColor, backgroundColor: defaultColor, target: self, action: #selector(tabBoard))
    lazy var buttonLocal = createCustomButton(title: "Ver Localidades", titleColor: .white, borderColor: defaultColor, backgroundColor: defaultColor, target: self, action: #selector(tabLocal))

    

    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    
	//  MARK: - View - Initialization
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
            top: topAnchor, paddingTop: 200,
            leading: leadingAnchor, paddingLeading: 30,
            trailing: trailingAnchor, paddingTrailing: 30
        )
        stackButton.anchor(
            top: stackHome.bottomAnchor, paddingTop: 100,
            leading: leadingAnchor, paddingLeading: 30,
            trailing: trailingAnchor, paddingTrailing: 30
        )
        
        buttonBoard.anchor(height: 45)
        buttonLocal.anchor(height: 45)
    
    }
    
    @objc private func tabBoard() {
        tabGoBoard?()
    }
    
    @objc private func tabLocal() {
        tabGoLocal?()
    }
    
    func updateData(_ nombre: String, _ identificacion: String, _ usuario: String) {
        name.text = "Nombre:   \(nombre)"
        id.text = "Identificacion:   \(identificacion)"
        user.text = "Usuario:   \(usuario)"
    }

    func configView() {
        // fill & config Self view
    }
}

