//
//  ViewControllerDelegate.swift
//  SideMenuApp
//
//  Created by dam2 on 24/1/24.
//

import UIKit

// Creamos un protocolo para definir el método que se invoca cuando el usuario selecciona una opción del menú
protocol ViewControllerDelegate: AnyObject {
    func didSelectMenuItem(named: String)
}
