//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 15/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    lazy var urlPadrao: String = {
        guard let urlPadrao = Configuracao().getUrlPadrao() else {return ""}
        return urlPadrao
    }()

    // MARK - GET
   
    
    func recuperaAlunos(completion:@escaping()->Void){
        
            Alamofire.request(urlPadrao + "api/aluno",method: .get).responseJSON { (response) in
            
            switch response.result {
                case .success:
                    if let resposta = response.result.value as? Dictionary<String,Any> {
                        self.serializaAlunos(resposta)
                    completion()
                    }
                    
                    break
                case .failure:
                        print(response.error!)
                        completion()
                        break
                }
            }
        }
    
    func recuperaUltimosAlunos(_ versao:String, completion:@escaping()->Void){
        Alamofire.request(urlPadrao + "api/aluno/diff", method: .get, headers: ["datahora":versao]).responseJSON { (response) in
            switch response.result{
                case .success:
                    print("Ultimos Alunos")
                    if let resposta = response.result.value as? Dictionary<String,Any>{
                        self.serializaAlunos(resposta)
                    }
                    completion()
                break
                case .failure:
                    print("Falha")
                break
            }
        }
        
    }
    
    
    
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros:Array<Dictionary<String, Any>>, completion:@escaping(_ salvo:Bool)->Void){
        
        guard let url = URL(string: urlPadrao+"api/aluno/lista") else {return}
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao).responseData { (resposta) in
            if resposta.error == nil {
                completion(true)
            }
        }
    }


    // MARK: - DELETE
    
    func deletaAluno(id:String, completion:@escaping(_ apagado:Bool)->Void){
        
        Alamofire.request(urlPadrao+"api/aluno/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result{
            case .success:
                completion(true)
                break
            case .failure:
                print(resposta.result.error!)
                completion(false)
                break
           
            }
        }
        
    }

    // MARK: - Serialização
    
    func serializaAlunos(_ resposta:[String:Any]){
        guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String,Any>> else {return}
        for dicionarioDeAlunos in listaDeAlunos{
            guard let status = dicionarioDeAlunos["desativado"] as? Bool else {return}
            if status{
                guard let idDoAluno = dicionarioDeAlunos["id"] as? String else {return}
                guard let UUIDAluno = UUID(uuidString: idDoAluno) else {return}
                if let aluno = AlunoDAO().recuperaAlunos().filter({$0.id == UUIDAluno}).first{
                    AlunoDAO().deletaAluno(aluno: aluno)
                }
            }else{
                AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAlunos)
            }
            
        }
        AlunoUserDefaults().salvaVersao(resposta)
        
    }

}
