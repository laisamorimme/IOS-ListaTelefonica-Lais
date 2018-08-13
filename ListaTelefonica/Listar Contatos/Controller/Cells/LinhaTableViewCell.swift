//
//  LinhaTableViewCell.swift
//  ListaTelefonica
//
//  Created by lais amorim menezes on 30/07/2018.
//  Copyright © 2018 lais amorim menezes. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
import MGSwipeTableCell

class LinhaTableViewCell: MGSwipeTableCell, NibReusable {
    
    //outlet:
    @IBOutlet weak var imagemPerfil: UIImageView!
    @IBOutlet weak var labelNomePessoa: UILabel!
 
    //atribuindo as coisas da linha, como a labelNome e a imagemPerfil:
    func bind(contato: ContatoView) {
        
        self.labelNomePessoa.text = contato.nome
        
        if let url = contato.avatarUrl {
            
            self.imagemPerfil.kf.setImage(with: url)
        }
    }
}
