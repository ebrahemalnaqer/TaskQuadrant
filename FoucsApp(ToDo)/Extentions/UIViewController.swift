//
//  UIViewController.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//


import UIKit

extension UIViewController {
    
    func nav(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
