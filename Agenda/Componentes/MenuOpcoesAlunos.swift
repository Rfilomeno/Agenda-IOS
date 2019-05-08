//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

enum MenuActionSheetAluno {
    case sms, ligacao
}

class MenuOpcoesAlunos: NSObject {
    
    
    func configuraMenuDeOpcoesDoAluno(completion: @escaping(_ opcao:MenuActionSheetAluno) -> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        
        let sms = UIAlertAction(title: "Enviar SMS", style: .default, handler: {(acao) in
            completion(.sms)
        })
        menu.addAction(sms)
        let ligacao = UIAlertAction(title: "Ligar", style: .default, handler: {(acao) in
            completion(.ligacao)
        })
        menu.addAction(ligacao)
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
