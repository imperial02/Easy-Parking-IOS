//
//  SectionViewController.swift
//  Easy - Parking
//
//  Created by Lyubomyr Drevych on 11/14/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let name = ["A1","B1","C1","D1","E1","F1","G1","H1","J1","I1"]
    private let totalCount = [100,22,44,67,51,4,99,14,56,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.cellName, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdent)
    }
    

}

extension SectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdent, for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
        let data = name[indexPath.row]
        let model = totalCount[indexPath.row]
        cell.sectionLabel.text = data
        cell.totalCount.text = "\(model)"
        cell.pieChartUpdate()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension SectionViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / Constants.numbersOfColumns - Constants.spaceBetweenCell
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
