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

protocol ContatoServiceDelegate {
    func getContatosSuccess()
    func getContatosFailure(error: String)
}

class ContatoService{
    
    var delegate:ContatoServiceDelegate
    
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
}
