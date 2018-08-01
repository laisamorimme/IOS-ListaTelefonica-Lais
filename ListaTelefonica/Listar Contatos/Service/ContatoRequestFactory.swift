//
//  ContatoRequestFactory.swift
//  ListaTelefonica
//
//  Created by Lilian Amorim on 19/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import Foundation
import Alamofire

class ContatoRequestFactory {
    
    static func getContato() -> DataRequest{
       
        return Alamofire.request(baseUrl + "contacts", method: .get, headers: header)
    }
    
}
