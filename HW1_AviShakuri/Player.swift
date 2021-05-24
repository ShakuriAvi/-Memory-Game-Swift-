//
//  Player.swift
//  HW1_AviShakuri
//
//  Created by מוטי שקורי on 15/05/2021.
//

import UIKit

class Player : Codable {
    var name: String
   var minutes: Int
   var seconds: Int
    var moves: Int
    var lat: Float
    var lon: Float
    init(name: String,minutes: Int,seconds: Int,moves: Int,lat:Float,lon:Float) {
        self.name = name
        self.minutes = minutes
        self.seconds = seconds
        self.moves = moves
        self.lat = lat
        self.lon = lon

      }
    
    required init?(coder aDecoder: NSCoder){
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        minutes = aDecoder.decodeObject(forKey: "minutes") as? Int ?? 0
        seconds = aDecoder.decodeObject(forKey: "seconds") as? Int ?? 0
        moves = aDecoder.decodeObject(forKey: "moves") as? Int ?? 0
        lat = aDecoder.decodeObject(forKey: "lat") as? Float ?? 0.0
        lon = aDecoder.decodeObject(forKey: "lon") as? Float ?? 0.0
    }
    
    func encode(with aCoder : NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(minutes, forKey: "minutes")
        aCoder.encode(seconds, forKey: "seconds")
        aCoder.encode(moves, forKey: "moves")
        aCoder.encode(moves, forKey: "lat")
        aCoder.encode(moves, forKey: "lon")
    }
    
}
