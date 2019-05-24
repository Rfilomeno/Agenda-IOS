//
//  Mensagem.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Mensagem: NSObject, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate  {
    
    var delegate:MFMessageComposeViewControllerDelegate?
    
    func setaDelegate() ->MFMessageComposeViewControllerDelegate?{
        delegate = self
        return delegate
    }
    
    // MARK: - metodos
    
    func enviaSms(_ aluno:Aluno, controller:UIViewController) {
        if MFMessageComposeViewController.canSendText(){
            let componenteMensagem = MFMessageComposeViewController()
            guard let telefone = aluno.telefone else{return }
            componenteMensagem.recipients = [telefone]
            guard let delegate = setaDelegate() else {return }
            componenteMensagem.messageComposeDelegate = delegate
            //present(componenteMensagem)
            controller.present(componenteMensagem, animated: true, completion: nil)
            
        }
       
        
    }
    
    // MARK: - Delegate Methods
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    

}
