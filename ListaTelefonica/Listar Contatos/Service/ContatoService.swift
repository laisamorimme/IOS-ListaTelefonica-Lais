//
//  ContatoService.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

//metodos que seram implementados lá em baixo:
protocol ContatoServiceDelegate {
    func getContatosSuccess()
    func getContatosFailure(error: String)
   
}

class ContatoService{
    
    var delegate:ContatoServiceDelegate
    
    //init: construtor
    required init(delegate: ContatoServiceDelegate){
        self.delegate = delegate
    }
    
    func getContato(){
        
        ContatoRequestFactory.getContato().validate().responseArray{ (response: DataResponse<[Contato]>) in
            switch response.result{
                
            case .success:
                if let contatos = response.result.value{
                    
                    ContatoViewModel.clear()
                    ContatoViewModel.save(contatos: contatos)
                }
                self.delegate.getContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.getContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    func postContato(nomeContato: String, aniversarioContato: Int, emailContato: String, telefoneContato: String, imagemContato: String){
        
        ContatoRequestFactory.criarContato(nome: nomeContato, aniversario: aniversarioContato, email: emailContato, telefone: telefoneContato, imagem: imagemContato).validate().responseObject { (response: DataResponse<Contato>) in
        
            switch response.result{
                
            case .success:
                
                if let contato = response.result.value{
                    
                    ContatoViewModel.save(contatos: [contato])
                }
                
                self.delegate.getContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.getContatosFailure(error: error.localizedDescription)
            }
        }
    }
    
    func delContato(id: Int) {
        
        ContatoRequestFactory.del(contatoId: id).validate().responseJSON { (response: DataResponse<Any>) in
            
            switch response.result{
            
            case .success:
                
                self.delegate.getContatosSuccess()
                
            case .failure(let error):
                
                self.delegate.getContatosFailure(error: error.localizedDescription)
            }
        }
    }
}
