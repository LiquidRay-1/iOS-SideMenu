//
//  ContentViewController.swift
//  SideMenuApp
//
//  Created by dam2 on 24/1/24.
//

import UIKit

class ContentViewController: UIViewController {

    // Creamos una variable para almacenar el nombre de la opción seleccionada
    private var optionName: String = "Home"
        
    // Creamos una variable para asignar el delegado del controlador de vista del contenido
    weak var delegate: ContentViewControllerDelegate?
        
    // Creamos una etiqueta para mostrar el nombre de la opción seleccionada
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
        
    // Creamos un botón para abrir o cerrar el menú
    private let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.tintColor = .white
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Añadimos la etiqueta y el botón a la vista del controlador
        view.addSubview(optionLabel)
        view.addSubview(menuButton)
            
        // Añadimos un gesto de acción al botón
        menuButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
            
        // Asignamos un color de fondo aleatorio a la vista del controlador
        view.backgroundColor = UIColor(red: .random(in: 0...1),
                                        green: .random(in: 0...1),
                                        blue: .random(in: 0...1),
                                        alpha: 1)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        // Aplicamos restricciones de AutoLayout a la etiqueta y al botón
        optionLabel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        menuButton.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
    }
        
    // Creamos un método para actualizar el nombre de la opción seleccionada y el color de fondo de la vista
    func update(with optionName: String) {
        self.optionName = optionName
        optionLabel.text = optionName
        view.backgroundColor = UIColor(red: .random(in: 0...1),
                                        green: .random(in: 0...1),
                                        blue: .random(in: 0...1),
                                        alpha: 1)
    }
        
    // Creamos un método para notificar al delegado cuando el usuario pulsa el botón del menú
    @objc func didTapMenuButton() {
            delegate?.didTapMenuButton()
    }
}
