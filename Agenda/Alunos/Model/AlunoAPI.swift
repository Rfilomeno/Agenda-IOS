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

    // MARK - GET
    
    func recuperaAlunos(completion:@escaping()->Void){
        
        
        Alamofire.request("http://localhost:8080/api/aluno",method: .get).responseJSON { (response) in
            
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
    
    
    
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros:Array<Dictionary<String, String>>){
        guard let url = URL(string: "http://localhost:8080/api/aluno/lista") else {return}
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao)
    }
}
