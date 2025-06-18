//
//  customDataCellTableViewCell.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 18/06/25.
//

import UIKit
/// Celda personalizada reutilizable para mostrar tanto datos de tabla como de localidad.
class customDataCellTableViewCell: UITableViewCell {
    
    static let identifier = "CustomDataCardCell" 
    
    private let containerStack = UIStackView()

    /// Inicializador principal de la celda.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureStack() // Configura el stack
        contentView.addSubview(containerStack)
        
        /// Aplica restricciones usando .anchor
        containerStack.anchor(
            top: contentView.topAnchor, paddingTop: 10,
            leading: contentView.leadingAnchor, paddingLeading: 15,
            trailing: contentView.trailingAnchor, paddingTrailing: 15,
            bottom: contentView.bottomAnchor, paddingBottom: 10
        )
        
        contentView.backgroundColor = .white
        containerStack.backgroundColor = UIColor(white: 0.95, alpha: 1)
        containerStack.layer.cornerRadius = 12
        containerStack.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configura la celda con los datos segun el tipo de contenido (tabla o localidad).
    func configure(with data: CellData) {
        containerStack.arrangedSubviews.forEach { $0.removeFromSuperview() } // Limpia el contenido previo
        
        var campos: [String] = []

        switch data {
        case .tabla(let tabla):
            /// Formatea la fecha
            let formatter = DateFormatter()
            formatter.dateFormat = "dd 'de' MMMM 'de' yyyy, HH:mm"
            formatter.locale = Locale(identifier: "es_ES")
            let fechaString = tabla.fechaActualizacionSincro != nil ? formatter.string(from: tabla.fechaActualizacionSincro!) : "Sin fecha"
            
            /// Construye los campos a mostrar
            campos = [
                "NombreTabla: \(tabla.nombreTabla ?? "-")",
                "PK: \(tabla.pk ?? "-")",
                "Query: \(tabla.queryCreacion ?? "-")",
                "BatchSize: \(tabla.batchSize)",
                "Filtro: \(tabla.filtro ?? "-")",
                "Error: \(tabla.error ?? "-")",
                "Campos: \(tabla.numeroCampos)",
                "MetodoApp: \(tabla.metodoApp ?? "-")",
                "Fecha: \(fechaString)"
            ]
            
        case .localidad(let loc):
            campos = [
                "Ciudad: \(loc.AbreviacionCiudad ?? "-")",
                "Nombre completo: \(loc.NombreCompleto ?? "-")"
            ]
        }

        campos.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            containerStack.addArrangedSubview(label)
        }
    }

    /// Configura el stackView.
    private func configureStack() {
        containerStack.axis = .vertical
        containerStack.spacing = 8
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        containerStack.isLayoutMarginsRelativeArrangement = true
    }
}
