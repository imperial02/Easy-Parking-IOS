//
//  SectionCollectionViewCell.swift
//  Easy - Parking
//
//  Created by Любчик on 11/1/18.
//  Copyright © 2018 Easy-Parking. All rights reserved.
//

import UIKit
import Charts

class SectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
 
    func pieChartUpdate() {
        
        let category1 = PieChartDataEntry(value: 80.0)
        let sum1 = PieChartDataEntry(value: 20.0)
        let dataSet1 = PieChartDataSet(values: [category1, sum1], label: nil)
        let data1 = PieChartData(dataSet: dataSet1)
        let colors = [UIColor.green, UIColor.yellow]
        dataSet1.selectionShift = 0
        dataSet1.valueColors = [UIColor.clear]
        dataSet1.colors = colors
        pieChart.data = data1
    }
    
}
