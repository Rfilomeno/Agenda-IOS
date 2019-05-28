//
//  AlunoUserDefaults.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 28/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class AlunoUserDefaults: NSObject {

    let preferencia = UserDefaults.standard
    
    func salvaVersao(_ json:Dictionary<String,Any>){
        guard let versao = json["momentoDaUltimaModificacao"] as? String else {return}
        preferencia.set(versao, forKey: "ultima-versao")
    }
    
    func recuperaUltimaVersao() -> String? {
        let versao = preferencia.object(forKey: "ultima-versao") as? String
        return versao
    }
}
