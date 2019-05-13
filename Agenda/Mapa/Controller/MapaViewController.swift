//
//  MapaViewController.swift
//  Agenda
//
//  Created by Rodrigo Filomeno on 08/05/2019.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    var aluno:Aluno?
    @IBOutlet weak var mapa: MKMapView!
    lazy var localizacao = Localizacao()
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        verificaAutoriacaoDoUsuario()
        
        mapa.delegate = localizacao
        gerenciadorDeLocalizacao.delegate = self
    }
    
    func getTitulo() -> String{
        return "Localizar alunos"
    }
    
    func verificaAutoriacaoDoUsuario(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .authorizedWhenInUse:
                let botao = Localizacao().configuraBotaoDeLocalizacaoAtual(mapa)
                mapa.addSubview(botao)
                gerenciadorDeLocalizacao.startUpdatingLocation()
                break
            case .notDetermined:
                gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
                break
            case . denied:
                break
            default:
                break
            }
        }
    }
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas("Av. Rio Branco, 156, sala 3018, Centro, Rio de Janeiro") { (localizacaoEncontrada) in
            //let pino = self.configuraPino(titulo: "Escritório", localizacao: localizacaoEncontrada)
            let pino = Localizacao().configuraPino(titulo: "Escritório", localizacao: localizacaoEncontrada, cor: .black, icone: nil)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 1000, 1000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
            self.localizarAluno()
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(aluno.endereco!,local: { (localizacaoEncontrada) in
                //let pino = self.configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: <#T##UIColor?#>, icone: <#T##UIImage?#>)
                self.mapa.addAnnotation(pino)
                self.mapa.showAnnotations(self.mapa.annotations, animated: true)
            })
        }
        
    }
    
    

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoDeLocalizacaoAtual(mapa)
            mapa.addSubview(botao)
            gerenciadorDeLocalizacao.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }

}
