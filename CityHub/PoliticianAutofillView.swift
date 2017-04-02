//
//  PoliticianAutofillView.swift
//  CityHub
//
//  Created by Jack Cook on 4/2/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import UIKit

class PoliticianAutofillView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var autofillDelegate: PoliticianAutofillViewDelegate?
    private var politicians = [Politician]()
    
    init(delegate: PoliticianAutofillViewDelegate?) {
        super.init(frame: .zero, style: .plain)
        
        autofillDelegate = delegate
        
        dataSource = self
        self.delegate = self
        
        separatorInset = .zero
        
        CityHubClient.shared.politicians.getPoliticians(zipcode: "10028") { politicians, error in
            guard let politicians = politicians else {
                return
            }
            
            self.politicians = politicians.reversed()
            
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return politicians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return PoliticianCell(politician: politicians[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        autofillDelegate?.selectedPolitician(politicians[indexPath.row])
    }
}

protocol PoliticianAutofillViewDelegate {
    func selectedPolitician(_ politician: Politician)
}
