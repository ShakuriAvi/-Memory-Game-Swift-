//
//  ViewController.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 01/05/2021.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate {
   
    
    @IBOutlet weak var menu_BTN_play: UIButton!
    @IBOutlet weak var menu_BTN_setting: UIButton!
    @IBOutlet weak var menu_BTN_topTen: UIButton!
    var player : Player!
    var dict=[String:AnyObject]()
    var locationManager: CLLocationManager!
    var playerArr:Array = [Player]()
    var lat: Float = 0.0
    var lon: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        print("new")
    }

    @IBAction func back_Button(_ sender: Any) {
        
    }
    func sortArray(){
        if (player != nil){
            playerArr.append(player)
            if(playerArr.count > 1){
                playerArr=playerArr.sorted(by: {($0.moves ) < $1.moves })
            }
            if(playerArr.count > 10){
                playerArr.remove(at: 10)
            }
            writeJson()
            }
    }

    func read(){
       // print(UserDefaults.standard.object(forKey:"player") as! [String : AnyObject])
        if UserDefaults.standard.object(forKey:"player") != nil {
            dict = UserDefaults.standard.object(forKey:"player") as! [String : AnyObject]
                player = Player( name: dict["name"] as! String,minutes: dict["minutes"]! as! Int,seconds: dict["seconds"]! as! Int,moves: dict["moves"]! as! Int,lat: lat,lon: lon)
        }
        
            let temp = UserDefaults.standard.string(forKey:"currentTopTen")
            if let safePlayer = temp{
                let decoder = JSONDecoder()
                let data = Data(safePlayer.utf8)
                do{
                    playerArr = try decoder.decode([Player].self, from: data)
                    
                }catch{}
            }
    }
    
    func writeJson(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(playerArr)
        let temp :String = String(data: data, encoding: .utf8)!
        UserDefaults.standard.setValue(temp, forKey: "currentTopTen")
        
    }
    func takeLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        
        if(sender.tag==0){
            takeLocation()
            read()
            UserDefaults.standard.removeObject(forKey: "player")
            sortArray()
  
                let nextViewController = storyBoard.instantiateViewController(  identifier: "MemoryGameViewController") as! MemoryGameViewController
                self.present(nextViewController, animated:true, completion:nil)
    }
        else if(sender.tag==1){
        //    UserDefaults.standard.removeObject(forKey: "currentTopTen")
       //     UserDefaults.standard.removeObject(forKey: "player")
            takeLocation()
            read()
            UserDefaults.standard.removeObject(forKey: "player")
            sortArray()
                let nextViewController = storyBoard.instantiateViewController(  identifier: "TopViewController") as! TopViewController
                self.present(nextViewController, animated:true, completion:nil)
           // self.dismiss(animated:true,completion:nil)
        }else{
            let nextViewController = storyBoard.instantiateViewController(  identifier: "SettingViewController") as! SettingViewController
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location ready")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            lat = Float(location.coordinate.latitude)
            lon = Float(location.coordinate.longitude)
            print("Locations: \(lat) \(lon)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
  
    }



