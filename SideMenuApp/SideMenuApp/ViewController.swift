//
//  ViewController.swift
//  SideMenuApp
//
//  Created by dam2 on 24/1/24.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {
    
    func didSelectOption(_ option: MenuOption) {
        closeMenu()
    }

    // Creamos una instancia del controlador de vista del menú
    private let menuViewController = MenuViewController()
        
    // Creamos una instancia del controlador de vista del contenido
    private let contentViewController = ContentViewController()
        
    // Creamos una variable para almacenar el estado del menú (abierto o cerrado)
    private var isMenuOpen = false
        
    // Creamos una constante para definir la anchura del menú
    private let menuWidth: CGFloat = 200
        
    // Creamos una constante para definir la duración de la animación del menú
    private let menuAnimationDuration: TimeInterval = 0.3
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Añadimos el controlador de vista del menú como hijo del controlador de vista principal
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
            
        // Añadimos el controlador de vista del contenido como hijo del controlador de vista principal
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
            
        // Asignamos el controlador de vista principal como delegado del controlador de vista del menú
        menuViewController.delegate = self
            
        // Asignamos el controlador de vista principal como delegado del controlador de vista del contenido
        contentViewController.delegate = self
            
        // Configuramos las restricciones de AutoLayout para el controlador de vista del menú
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuViewController.view.widthAnchor.constraint(equalToConstant: menuWidth)
        ])
            
        // Configuramos las restricciones de AutoLayout para el controlador de vista del contenido
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
        
    // Creamos una función para abrir el menú
    private func openMenu() {
        // Cambiamos el estado del menú a abierto
        isMenuOpen = true
            
        // Creamos una animación para desplazar el controlador de vista del contenido a la derecha
        UIView.animate(withDuration: menuAnimationDuration) {
            self.contentViewController.view.frame.origin.x = self.menuWidth
        }
    }
        
    // Creamos una función para cerrar el menú
    private func closeMenu() {
        // Cambiamos el estado del menú a cerrado
        isMenuOpen = false
            
        // Creamos una animación para desplazar el controlador de vista del contenido a la izquierda
        UIView.animate(withDuration: menuAnimationDuration) {
            self.contentViewController.view.frame.origin.x = 0
        }
    }
        
    // Creamos una función para alternar el menú
    private func toggleMenu() {
        // Si el menú está abierto, lo cerramos
        if isMenuOpen {
            closeMenu()
        }
        // Si el menú está cerrado, lo abrimos
        else {
            openMenu()
        }
    }
}

// Creamos una extensión para implementar el protocolo MenuViewControllerDelegate
extension ViewController: ViewControllerDelegate {
    func didSelectMenuItem(named: String) {
        // Actualizamos el controlador de vista del contenido con el nombre de la opción seleccionada
        contentViewController.update(with: named)
        // Cerramos el menú
        closeMenu()
    }
}

// Creamos una extensión para implementar el protocolo ContentViewControllerDelegate
extension ViewController: ContentViewControllerDelegate {
        
    // Implementamos la función didTapMenuButton para recibir el evento de pulsar el botón del menú en el controlador de vista del contenido
    func didTapMenuButton() {
        // Alternamos el menú
        toggleMenu()
    }
}
