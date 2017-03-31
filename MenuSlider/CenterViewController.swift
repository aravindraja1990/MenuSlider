//
//  CenterViewController.swift
//  MenuSlider
//
//  Created by aravind raja on 8/25/16.
//  Copyright © 2016 aravind raja. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    var delegate : SliderNavigationProtocol?
    var index: Int? = 0
    @IBAction func toggleLeftMenu(_ sender: UIBarButtonItem) {
        delegate?.toggleLeftMenu(sender: sender,userInfo: ["menuIndex": index! as AnyObject])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
