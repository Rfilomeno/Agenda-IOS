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
                        guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String,Any>> else {return}
                        for dicionarioDeAlunos in listaDeAlunos{
                            AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAlunos)
                        }
                    
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
    
    func recuperaUltimosAlunos(_ versao:String){
        Alamofire.request(urlPadrao + "api/aluno/diff", method: .get, headers: ["datahora":versao]).responseJSON { (response) in
            switch response.result{
                case .success:
                    print("Ultimos Alunos")
                case .failure:
                    print("Falha")
            }
        }
        
    }
    
    
    
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros:Array<Dictionary<String, String>>){
        
        guard let url = URL(string: urlPadrao+"api/aluno/lista") else {return}
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao)
    }


    // MARK: - DELETE
    
    func deletaAluno(id:String){
        
        Alamofire.request(urlPadrao+"api/aluno/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result{
            case .failure:
                print(resposta.result.error!)
                break
            default:
                break
            }
        }
        
    }



}
