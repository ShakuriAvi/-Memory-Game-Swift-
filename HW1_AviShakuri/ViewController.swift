//
//  ViewController.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 01/05/2021.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var menu_BTN_play: UIButton!

    @IBOutlet weak var menu_BTN_topTen: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        if(sender.tag==0){
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            let nextViewController = storyBoard.instantiateViewController(  identifier: "MemoryGameViewController") as! MemoryGameViewController
            self.present(nextViewController, animated:true, completion:nil)
    }
    }

}

