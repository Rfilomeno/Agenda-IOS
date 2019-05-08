//
//  Localizacao.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import CoreLocation

class Localizacao: NSObject {

    
    func converteEnderecoEmCoordenadas(_ endereco:String , local:@escaping (_ local:CLPlacemark)->Void){
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco) { (listaDeLocalizacoes, error) in
            if let localizacao = listaDeLocalizacoes?.first{
                local(localizacao)
            }
        }
    }
    
    
}
