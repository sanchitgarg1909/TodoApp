//
//  ViewController.swift
//  AlamofireApp
//
//  Created by Sanchit Garg on 28/09/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let baseUrl:String = "http://jsonplaceholder.typicode.com"
    var api:String = ""
    
    @IBAction func getButtonPressed(sender:AnyObject){
        api=baseUrl+"/todos/1"
        Alamofire.request(api)
            .responseJSON { response in
                // ...
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let todo = JSON(value)
                    // now we have the results, let's just print them though a tableview would definitely be better UI:
                    print("The todo is: " + todo.description)
                    if let title = todo["title"].string {
                        // to access a field:
                        print("The title is: " + title)
                    } else {
                        print("error parsing /todos/1")
                    }
                }
        }
    }
    
    @IBAction func postButtonPressed(sender:AnyObject){
        api=baseUrl+"/todos"
        let newTodo:Parameters = ["title": "First Post", "completed": false, "userId": 1]
        Alamofire.request(api,method: .post,parameters: newTodo)
            .responseJSON { response in
                // ...
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                guard let value = response.result.value else {
                    print("no result data received when calling GET on /todos/1")
                    return
                }
                let todo = JSON(value)
                print("The todo is: " + todo.description)
        }
    }
    
    @IBAction func deleteButtonPressed(sender:AnyObject){
        api=baseUrl+"/todos/1"
        Alamofire.request(api,method: .delete)
            .responseJSON { response in
                // ...
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling DELETE on /todos/1")
                    print(response.result.error!)
                    return
                }
                print("DELETE ok")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

