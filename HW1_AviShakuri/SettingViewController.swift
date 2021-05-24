//
//  SettingViewController.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 16/05/2021.
//

import UIKit
class SettingViewController: UIViewController {
    
    @IBOutlet weak var setting_BOX_choiceLevel: UISegmentedControl!
    @IBOutlet weak var setting_LBL_explain: UILabel!
    var choice: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        setting_LBL_explain.text = "for four rows (8 pairs of card) click First.\n for Five rows (10 pairs of card) click Seconds"
        
        let preferences = UserDefaults.standard
        let currentKey = "currentLevel"
        print(preferences.integer(forKey: currentKey))
     
        choice = preferences.integer(forKey: currentKey)
        setting_BOX_choiceLevel.selectedSegmentIndex=choice
    }
    
    @IBAction func changeOption(_ sender: Any) {
        if(choice != setting_BOX_choiceLevel.selectedSegmentIndex){
            choice = setting_BOX_choiceLevel.selectedSegmentIndex
      //      print(choice)
            writeSF()
        }
    }
    func writeSF(){

        let preferences = UserDefaults.standard
        let currentKey = "currentLevel"
        let currentChoice = choice
        preferences.set(currentChoice, forKey: currentKey)

        //  Save to disk
        let didSave = preferences.synchronize()

        if !didSave {
            //  Couldn't save (I've never seen this happen in real world testing)
        }

    }
}
