//
//  ViewController.swift
//  Github
//
//  Created by Luis Manuel Ramirez Vargas on 19/05/17.
//  Copyright © 2017 Luis Manuel Ramirez Vargas. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class ViewController: UIViewController {

    
    var provider: RxMoyaProvider<GitHub>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        provider = RxMoyaProvider<GitHub>()
        provider.request(GitHub.users(since: nil)).subscribe { event in
            switch event {
            case .next(let response):
                print(response)
            case .error(let error):
                print(error)
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

