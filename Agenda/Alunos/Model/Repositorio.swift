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
    
    func deletaAluno(aluno:Aluno){
        guard let id = aluno.id else {return}
        AlunoAPI().deletaAluno(id: String(describing: id).lowercased())
        AlunoDAO().deletaAluno(aluno: aluno)
    }
    
    func sincronizaAlunos(){
        let alunos = AlunoDAO().recuperaAlunos()
        var listaDeParamentros:Array<Dictionary<String, String>> = []
        for aluno in alunos{
            let paramentros:Dictionary<String, String> = [
                "id" : "\(String(describing: aluno.id).lowercased())",
                "nome" : aluno.nome ?? "",
                "endereço" : aluno.endereco ?? "",
                "telefone" : aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "nota" :  "\(aluno.nota)"
            ]
            listaDeParamentros.append(paramentros)
        }
        AlunoAPI().salvaAlunosNoServidor(parametros: listaDeParamentros)
        
        
    }
    
}
