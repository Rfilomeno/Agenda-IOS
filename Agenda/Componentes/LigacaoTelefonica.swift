//
//  LigacaoTelefonica.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 24/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefonica: NSObject {
    
    func fazLigacao(_ alunoSelecionado:Aluno){
        
        guard let numeroTelefone = alunoSelecionado.telefone else {return}
        if let url = URL(string: "tel://\(numeroTelefone)"), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            print("Não Funciona em simulador")
        }

    }

}
