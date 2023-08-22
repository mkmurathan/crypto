//
//  ViewController.swift
//  Cripto
//
//  Created by Murathan karagöz on 22.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!

    
    let cryptoVM = CryptoViewModel()
    let disposebag = DisposeBag()
    
    var cryptoList = [crypto]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        /*
        tableView.delegate = self
        tableView.dataSource = self
        */
        
        tableView.rx.setDelegate(self).disposed(by: disposebag)
        
        setupBindings()
        cryptoVM.RequestData()
        
        
        view.backgroundColor = .black
    }

    
    func setupBindings() {
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in print(errorString)}
            .disposed(by: disposebag)
        
        /*
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposebag)
          */
        
        cryptoVM
            .loading
            .bind(to: self.indicator.rx.isAnimating)
            .disposed(by: disposebag)
        
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row, item, cell in cell.item = item}
            .disposed(by: disposebag)
            
        
        tableView.rx
            .modelSelected(crypto.self)
            .subscribe(onNext: { item in
                print("SelectedItem: \(item.currency)")
                }).disposed(by: disposebag)
            
    }
    
    
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cryptoList.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        
        return cell
    }
*/
    
    
    
}

