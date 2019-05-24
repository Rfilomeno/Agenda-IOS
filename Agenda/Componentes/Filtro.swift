//
//  Filtro.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 24/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Filtro: NSObject {
    
    
    func filtraAlunos(listaDeAlunos:Array<Aluno>, texto:String) -> Array<Aluno>{
        let alunosEncontrados = listaDeAlunos.filter { (aluno) -> Bool in
            
            if let nome = aluno.nome {
                return nome.contains(texto)
            }
            return false
        }
        
        
        return alunosEncontrados
    }

}
