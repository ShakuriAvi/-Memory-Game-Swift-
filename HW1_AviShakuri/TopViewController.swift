//
//  TopTenViewontroller.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 13/05/2021.
//
import UIKit
import MapKit
class TopViewController: UIViewController {


    @IBOutlet weak var mapView: MKMapView!
    var player : Player!
    var playerArr:Array = [Player]()
    var flag = false
    var annotation :MKPointAnnotation!
  
   // var locationManager: CLLocationManager!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.mapView.delegate = self
        readJson()        //readJson()
        if(playerArr.count != 0 ){
        for item in playerArr {
            print("\(item.lon) and \(item.lat)")
        }
        }
        initView()
        
        }

    @IBAction func back_Button(_ sender: Any) {
        self.dismiss(animated:true,completion:nil)
    }
    func readJson(){
        let temp = UserDefaults.standard.string(forKey:"currentTopTen")
        if let safePlayer = temp{
            let decoder = JSONDecoder()
            let data = Data(safePlayer.utf8)
            do{
                playerArr = try decoder.decode([Player].self, from: data)
                
            }catch{}
        }
    }
    
    func initView(){
        tableView.delegate=self
        tableView.dataSource=self
    }
}

extension TopViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       let location = CLLocationCoordinate2D(latitude: Double(playerArr[indexPath.row].lat), longitude: Double(playerArr[indexPath.row].lon))
        if(flag != true){
           annotation = MKPointAnnotation()
            flag = true
            }
        else{
    self.mapView.removeAnnotation(annotation)
        }
        annotation.title = playerArr[indexPath.row].name
        mapView.addAnnotation(annotation)
        UIView.animate(withDuration: 1.0) {
            self.annotation.coordinate = location
        }
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(viewRegion, animated: true)
       
    }
    
}

extension TopViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(playerArr[indexPath.row].name ),  Moves:  \(playerArr[indexPath.row].moves )"
 
        cell.textLabel?.textColor=UIColor.orange
        return cell
    }
}


