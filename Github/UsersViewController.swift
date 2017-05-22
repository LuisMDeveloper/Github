//
//  UsersViewController.swift
//  Github
//
//  Created by Luis Manuel Ramirez Vargas on 21/05/17.
//  Copyright © 2017 Luis Manuel Ramirez Vargas. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Moya_ModelMapper
import Mapper
import RxCocoa
import RxOptional

class UsersViewController: UIViewController {

    var provider: RxMoyaProvider<GitHub>!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = RxMoyaProvider<GitHub>()
        findUsers(since: nil)
            .replaceNilWith([])
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.login
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
    }
    
    internal func findUsers(since: String?) -> Observable<[User]?> {
        return self.provider
            .request(GitHub.users(since: since))
            .debug()
            .mapArrayOptional(type: User.self)
        
    }


}
