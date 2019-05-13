//
//  AutenticacaoLocal.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 13/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    var error:NSError?

    func autorizaUsuario(completion:@escaping(_ autenticado:Bool)->Void){
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "É necessário autenticação para apagar um aluno") { (resposta, erro) in
                completion(resposta)
            }
        }
    }
    
}
