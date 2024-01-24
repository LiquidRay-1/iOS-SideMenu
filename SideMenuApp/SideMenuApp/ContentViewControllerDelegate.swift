//
//  ContentViewControllerDelegate.swift
//  SideMenuApp
//
//  Created by dam2 on 24/1/24.
//

import UIKit

// Creamos un protocolo para definir el método que se invoca cuando el usuario pulsa el botón del menú
protocol ContentViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}
