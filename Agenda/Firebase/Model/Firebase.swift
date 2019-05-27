//
//  Firebase.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 27/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

enum StatusDoAluno:Int {
    case ativo
    case inativo
}

class Firebase: NSObject {

    func enviaTokenParaServidor(token:String){
        
        
        guard let urlPadrao = Configuracao().getUrlPadrao() else {return}
        
        Alamofire.request(urlPadrao + "api/firebase/dispositivo", method: .post, headers: ["token":token]).responseData
        
    }
    
    func serializaMensagem(_ mensagem:MessagingRemoteMessage){
        guard let respostaDoFirebase = mensagem.appData["alunoSync"] as? String else {return}
        guard let data = respostaDoFirebase.data(using: .utf8) else {return}
        do{
            guard let mensagem2 = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> else {return}
            guard let listaDeAlunos = mensagem2["alunos"] as? Array<Dictionary<String, Any>> else {return}
            sincronizaAlunos(listaDeAlunos)
            NotificationCenter.default.post(name: NSNotification.Name("atualizaAlunos"), object: nil)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func sincronizaAlunos(_ alunos:Array<[String:Any]>){
        for aluno in alunos{
            guard let status = aluno["desativado"] as? Int else {return}
            if status == StatusDoAluno.ativo.rawValue{
                AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
            }else{
                guard let idDoAluno = aluno["id"] as? String else {return}
                guard let aluno = AlunoDAO().recuperaAlunos().filter({$0.id == UUID(uuidString: idDoAluno)}).first else {return}
                AlunoDAO().deletaAluno(aluno: aluno)
            }
            
        }
    }
    
}
