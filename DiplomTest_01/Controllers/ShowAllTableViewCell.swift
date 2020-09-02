//
//  ShowAllTableViewCell.swift
//  DiplomTest_01
//
//  Created by Глеб Никитенко on 10.04.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit


class ShowAllTableViewCell: UITableViewCell {
    
    //Button
    let containerView: UIButton = {
        let button = UIButton()
        button.setTitle("Показать все", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noah-Regular", size: 18)
        button.backgroundColor = .black
        return button
    }()
    
    let lineView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .black
        return lv
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        setupContainerView()
        
        addSubview(lineView)
        setupLineView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        lineView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    

}
