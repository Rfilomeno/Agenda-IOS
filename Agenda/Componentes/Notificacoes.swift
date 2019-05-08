//
//  Notificacoes.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Notificacoes: NSObject {
    
    func exibeNotificacaoDeMediaDosAlunos(dicionarioDeMedia : Dictionary<String,Any>) -> UIAlertController?{
        
        if let media = dicionarioDeMedia["media"] as? String{
            let alerta = UIAlertController(title: "Atencao", message: "a média geral dos alunos é: \(media)", preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
        }
        return nil
    }

}
