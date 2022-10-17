//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by Paul Lee on 2022/10/17.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var viewModel: MemoDetailViewModel!
    
    func bindViewModel() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
