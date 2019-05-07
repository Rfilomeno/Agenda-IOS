//
//  ImagePicker.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 07/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

enum MenuOpcoes {
    case camera, biblioteca
}

protocol ImagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto:UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK: - Atributos
    
    var delegate : ImagePickerFotoSelecionada?
    
    // MARK: - Métodos
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func menuDeOpcoes(completion:@escaping(_ opcao:MenuOpcoes)-> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Tirar Foto", style: .default) { (acao) in
            completion(.camera)
        }
        menu.addAction(camera)
        let biblioteca = UIAlertAction(title: "Biblioteca", style: .default) { (acao) in
            completion(.biblioteca)
        }
        menu.addAction(biblioteca)
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
    
    
}
