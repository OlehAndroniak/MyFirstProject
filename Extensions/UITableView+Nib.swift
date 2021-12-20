//
//  UITableView+Nib.swift
//  MyTMDB
//
//  Created by Орест Дерзкий on 13.12.2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, in bundle: Bundle? = nil) {
        let identifier = String(describing: name)
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn’t find UITableViewCell for \(String(describing: name)), make sure the cell is registered with the table view.")
        }
        return cell
    }
    
    func register<T: UIViewController>(nibWithClass name: T.Type, in bundle: Bundle? = nil) {
        let identifier = String(describing: name)
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
}



