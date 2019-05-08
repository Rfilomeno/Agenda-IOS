//
//  Mensagem.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Mensagem: NSObject, MFMessageComposeViewControllerDelegate {
    
    
    // MARK: - metodos
    
    func configuraSms(_ aluno:Aluno) -> MFMessageComposeViewController?{
        if MFMessageComposeViewController.canSendText(){
            let componenteMensagem = MFMessageComposeViewController()
            guard let telefone = aluno.telefone else{return componenteMensagem}
            componenteMensagem.recipients = [telefone]
            componenteMensagem.delegate = self
            return componenteMensagem
        }
        return nil
        
    }
    
    // MARK: - Delegate Methods
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    

}
