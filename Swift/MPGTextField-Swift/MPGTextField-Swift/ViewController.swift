//
//  ViewController.swift
//  MPGTextField-Swift
//
//  Created by Gaurav Wadhwani on 08/06/14.
//  Copyright (c) 2014 Mappgic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MPGTextFieldDelegate {
    
    var sampleData = [Dictionary<String, AnyObject>]()
    @IBOutlet var name : MPGTextField_Swift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.generateData()
        name!.mDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateData() {
        //var err : NSErrorPointer?
        let dataPath = Bundle.main.path(forResource: "sample_data", ofType: "json")
        let data = try? NSData(contentsOfFile: dataPath!, options: .uncached)
        var contents : [AnyObject]! = try? JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [AnyObject]
        //println(contents[0]["first_name"])
//        for var i = 0;i<contents.count;++i{
        for i in 0...(contents.count - 1) {
            var name = contents[i]["first_name"] as! String
            let lName = contents[i]["last_name"] as! String
            name += " " + lName
            let email = contents[i]["email"] as! String
            let dictionary = ["DisplayText":name,"DisplaySubText":email,"CustomObject":contents[i]] as [String : Any]
        
            sampleData.append(dictionary as [String : AnyObject])
        }

    }

    func dataForPopoverInTextField(textfield: MPGTextField_Swift) -> [Dictionary<String, AnyObject>] {
        return sampleData
    }
    
    func textFieldShouldSelect(textField: MPGTextField_Swift) -> Bool {
        return true
    }

    func textFieldDidEndEditing(textField: MPGTextField_Swift, withSelection data: Dictionary<String,AnyObject>) {
        print("Dictionary received = \(data)")
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let mpgTextField = cell.viewWithTag(420) as! MPGTextField_Swift
        mpgTextField.mDelegate = self;
        
        return cell
    }
}

