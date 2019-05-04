//
//  Production.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct ProductionCompany: Decodable {
    var id: Int?
    var name: String?
    var logo_path: String?
    var origin_country: String?
}
