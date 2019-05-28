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
        var alunos = AlunoDAO().recuperaAlunos().filter({$0.desativado == false})
        if alunos.count == 0{
            AlunoAPI().recuperaAlunos {
                alunos = AlunoDAO().recuperaAlunos()
            }
        }
        completion(alunos)
        
        
    }
    
    func recuperaUltimosAlunos(_ versao:String, completion:@escaping ()-> Void){
        AlunoAPI().recuperaUltimosAlunos(versao) {
            completion()
        }
    }
    
    func salvaAluno(aluno:Dictionary<String,Any>){
        
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno]) { (salvo) in
            if salvo{
                self.atualizaAlunoSincronizado(aluno)
            }
        }
    }
    
    func deletaAluno(aluno:Aluno){
        aluno.desativado = true
        AlunoDAO().atualizaContexto()
        guard let id = aluno.id else {return}
        AlunoAPI().deletaAluno(id: String(describing: id).lowercased()) { (apagado) in
            if apagado{
                AlunoDAO().deletaAluno(aluno: aluno)
            }
        }
        
    }
    
    func sincronizaAlunos(){
        enviaAlunosNaoSincronizados()
        sincronizaAlunosDeletados()
    }
    
    func enviaAlunosNaoSincronizados(){
        let alunos = AlunoDAO().recuperaAlunos().filter({$0.sincronizado == false})
        
        let listaDeParametros = criaJsonAluno(alunos)
        AlunoAPI().salvaAlunosNoServidor(parametros: listaDeParametros) { (salvo) in
            for aluno in listaDeParametros{
                self.atualizaAlunoSincronizado(aluno)
            }
        }
        
    }
    
    func sincronizaAlunosDeletados(){
        let alunos = AlunoDAO().recuperaAlunos().filter({$0.desativado == true})
        for aluno in alunos{
            deletaAluno(aluno: aluno)
        }
    }
    
    func criaJsonAluno(_ alunos:Array<Aluno>) -> Array<[String:Any]>{
        var listaDeParamentros:Array<Dictionary<String, String>> = []
        for aluno in alunos{
            guard let id = aluno.id else {return []}
            let paramentros:Dictionary<String, String> = [
                "id" : String(describing: id).lowercased(),
                "nome" : aluno.nome ?? "",
                "endereço" : aluno.endereco ?? "",
                "telefone" : aluno.telefone ?? "",
                "site" : aluno.site ?? "",
                "nota" :  "\(aluno.nota)"
            ]
            listaDeParamentros.append(paramentros)
        }
        return listaDeParamentros
    }
    
    func atualizaAlunoSincronizado(_ aluno:[String:Any]){
        var dicionario = aluno
        dicionario["sincronizado"] = true
        AlunoDAO().salvaAluno(dicionarioDeAluno: dicionario)
    }
    
}
