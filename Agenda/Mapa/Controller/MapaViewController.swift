//
//  MapaViewController.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    var aluno:Aluno?
    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
    }
    
    func getTitulo() -> String{
        return "Localizar alunos"
    }
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas("Av. Rio Branco, 156, sala 3018, Centro, Rio de Janeiro") { (localizacaoEncontrada) in
            let pino = self.configuraPino(titulo: "Escritório", localizacao: localizacaoEncontrada)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 1000, 1000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(aluno.endereco!,local: { (localizacaoEncontrada) in
                let pino = self.configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                self.mapa.addAnnotation(pino)
            })
        }
        
    }
    
    func configuraPino(titulo:String, localizacao:CLPlacemark) -> MKPointAnnotation{
        let pino = MKPointAnnotation()
        pino.title = titulo
        pino.coordinate = localizacao.location!.coordinate
        return pino
    }

   

}
