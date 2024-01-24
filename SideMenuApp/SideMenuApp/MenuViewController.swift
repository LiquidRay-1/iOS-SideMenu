//
//  MenuViewController.swift
//  SideMenuApp
//
//  Created by dam2 on 24/1/24.
//

import UIKit

// Creamos un enum para representar las opciones del menú
enum MenuOption: Int, CaseIterable {
    case home
    case profile
    case settings
    
    // Creamos una propiedad computada para obtener el título de cada opción
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    // Creamos una propiedad computada para obtener el color de cada opción
    var color: UIColor {
        switch self {
        case .home:
            return .systemBlue
        case .profile:
            return .systemGreen
        case .settings:
            return .systemOrange
        }
    }
}

// Creamos un protocolo para comunicar las acciones del usuario al controlador de vista principal
protocol MenuViewControllerDelegate: AnyObject {
    func didSelectOption(_ option: MenuOption)
}

class MenuViewController: UIViewController {
    
    // Creamos una propiedad para almacenar el delegado
    weak var delegate: MenuViewControllerDelegate?
    
    // Creamos una propiedad para almacenar la opción seleccionada
    private var selectedOption: MenuOption = .home
    
    // Creamos una propiedad para almacenar la tabla que muestra las opciones
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Añadimos la tabla a la vista del controlador
        view.addSubview(tableView)
        
        // Configuramos las restricciones de AutoLayout para la tabla
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Asignamos el controlador de vista como fuente de datos y delegado de la tabla
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// Creamos una extensión para implementar el protocolo UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    // Implementamos la función numberOfSections para devolver el número de secciones de la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Implementamos la función numberOfRowsInSection para devolver el número de filas de la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    // Implementamos la función cellForRowAt para devolver la celda que corresponde a cada fila de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Obtenemos una celda reutilizable con el identificador "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Obtenemos la opción del menú que corresponde al índice de la fila
        guard let option = MenuOption(rawValue: indexPath.row) else {
            return cell
        }
        
        // Configuramos el texto y el color de la celda según la opción
        cell.textLabel?.text = option.title
        cell.textLabel?.textColor = option.color
        
        // Devolvemos la celda
        return cell
    }
}

// Creamos una extensión para implementar el protocolo UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    // Implementamos la función didSelectRowAt para recibir el evento de seleccionar una fila de la tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Obtenemos la opción del menú que corresponde al índice de la fila
        guard let option = MenuOption(rawValue: indexPath.row) else {
            return
        }
        
        // Actualizamos la opción seleccionada
        selectedOption = option
        
        // Notificamos al delegado la opción seleccionada
        delegate?.didSelectOption(option)
    }
}
