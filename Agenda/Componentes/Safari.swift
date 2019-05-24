//
//  Safari.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 24/05/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import SafariServices

class Safari: NSObject {

    func abrePaginaWeb(_ alunoSelecionado:Aluno, controller:UIViewController){
        if let urlDoAluno = alunoSelecionado.site{
            var urlFormatada = urlDoAluno
            if !urlFormatada.hasPrefix("http://"){
                urlFormatada = "http://\(urlFormatada)"
            }
            guard let url = URL(string: urlFormatada) else {return}
            
            //UIApplication.shared.open(url, options: [:], completionHandler: nil)
            let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController,animated: true,completion: nil)
        }

    }
    
}
