//
//  ViewController.swift
//  handling-nested-uiscrollviews-scrolls
//
//  Created by Bisma S Wasesasegara on 05/08/20.
//  Copyright © 2020 Bisma S Wasesasegara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let scrollViews = [UIScrollView]()
    fileprivate let contentState = [false, true, false] // determine isWide
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
        collectionView.isPagingEnabled = true
        
        // MARK: collectionView flow layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = view.frame.size
        layout.itemSize.height = 400
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - ViewController collection view delegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // nillify cell items
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell
        
        cell?.subviews.forEach({ (view) in
            view.removeFromSuperview()
        })
    }
}

// MARK: - ViewCOntroller collection view data source
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell
        
        if indexPath.item < contentState.count {
            let isWide = contentState[indexPath.item]
            insertScrollview(isWide: isWide, to: cell)
            if isWide {
                cell?.backgroundColor = .blue
            }
        }
        
        return cell ?? UICollectionViewCell(frame: .zero)
    }
}

// MARK: -
final class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Make scrollviews
extension UIViewController {
    
    fileprivate func insertScrollview(isWide: Bool = false, to placeholder: UIView?) {
        
        guard let placeholder = placeholder else { return }
        let scrollview = UIScrollView()
        placeholder.addSubview(scrollview)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.heightAnchor.constraint(equalToConstant: 300).isActive = true
        scrollview.centerYAnchor.constraint(equalTo: placeholder.centerYAnchor).isActive = true
        scrollview.leadingAnchor.constraint(equalTo: placeholder.leadingAnchor).isActive = true
        scrollview.trailingAnchor.constraint(equalTo: placeholder.trailingAnchor).isActive = true
        
        let view = UIView()
        view.backgroundColor = isWide ? .green : .yellow
        scrollview.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.frame.width * (isWide ? 2 : 1)).isActive = true
        view.leadingAnchor.constraint(equalTo: scrollview.frameLayoutGuide.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor).isActive = true
        
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        label.text = isWide ?
            "looooooong looooooong loooooong looooooong looooooong looooooong loooooong" :
            "short"
    }
}
