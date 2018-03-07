//
//  weather.swift
//  Lab 4
//
//  Created by Alejandro Alvarez on 3/6/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import Foundation

struct observations: Decodable{
    let windSpeedMPH: Int
    let tempF: Int
    let weather : String
}
