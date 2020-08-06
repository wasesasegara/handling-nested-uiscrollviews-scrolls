//
//  Extension+UIView.swift
//  handling-nested-uiscrollviews-scrolls
//
//  Created by Bisma S Wasesasegara on 06/08/20.
//  Copyright © 2020 Bisma S Wasesasegara. All rights reserved.
//

import UIKit

extension UIView {
    
    func constrainEdges(to parent: UIView?) {
        
        if superview == nil {
            parent?.addSubview(self)
        }
        
        var parent: UIView {
            return (parent == nil ? superview : parent) ?? UIView()
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
    }
}
