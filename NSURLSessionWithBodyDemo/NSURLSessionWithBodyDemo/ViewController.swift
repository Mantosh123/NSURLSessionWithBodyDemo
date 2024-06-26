//
//  ViewController.swift
//  NSURLSessionWithBodyDemo
//
//  Created by mkumar on 07/03/21.
//  Copyright © 2021 mkumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var myDispatchGroup = DispatchGroup()
        myDispatchGroup.enter()
        networkManager.getDataFromHttpCall { (responseData, successStatus) in
            self.updateViewWithData(responseData: responseData)
            myDispatchGroup.leave()
        }
        myDispatchGroup.enter()
        networkManager.getDataFromHttpCall { (responseData, successStatus) in
            self.updateViewWithData(responseData: responseData)
            myDispatchGroup.leave()
        }
        myDispatchGroup.enter()
        networkManager.getDataFromHttpCall { (responseData, successStatus) in
            self.updateViewWithData(responseData: responseData)
            myDispatchGroup.leave()
        }
        myDispatchGroup.notify(queue: .main) {
          //get after all api called // refrash view with all data
        }
    }
    private func updateViewWithData(responseData: ResponseData) {
        if let data = responseData.body?.data {
            for myData in data {
                print(myData.med_name ?? "")
            }
        }
    }
}

