//
//  ParameterEncoderProtocol.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol ParameterEncoderProtocol {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}



