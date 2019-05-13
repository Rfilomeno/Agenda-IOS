//
//  Pino.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 13/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class Pino: NSObject, MKAnnotation {
    var title:String?
    var icon:UIImage?
    var color:UIColor?
    var coordinate: CLLocationCoordinate2D
    
    init(coordenada:CLLocationCoordinate2D){
        self.coordinate = coordenada
    }
    

}
