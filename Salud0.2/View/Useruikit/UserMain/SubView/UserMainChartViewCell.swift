//
//  UserMainChartViewCell.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/21.
//

import Foundation
import UIKit
import Charts

class UserMainChartViewCell:UIView{
    private lazy var ChartName : UILabel = {
        let chartname = UILabel()
        chartname.backgroundColor = .gray
        return chartname
    }()
    
    private lazy var linechart : LineChartView = {
        let linechart = LineChartView()
        return linechart
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        layer.backgroundColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        
        [ChartName,linechart].forEach{
            addSubview($0)
        }
        
        ChartName.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        linechart.snp.makeConstraints{
            $0.top.equalTo(ChartName)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}
