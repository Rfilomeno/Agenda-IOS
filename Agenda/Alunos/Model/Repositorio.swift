//
//  Repositorio.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 15/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {

    
    func recuperaAluno(completion:@escaping(_ listaDeAlunos:Array<Aluno>)->Void){
        var alunos = AlunoDAO().recuperaAlunos()
        if alunos.count == 0{
            AlunoAPI().recuperaAlunos {
                alunos = AlunoDAO().recuperaAlunos()
            }
        }
        completion(alunos)
        
        
    }
    
    func salvaAluno(aluno:Dictionary<String,String>){
        
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
    }
    
    
}
