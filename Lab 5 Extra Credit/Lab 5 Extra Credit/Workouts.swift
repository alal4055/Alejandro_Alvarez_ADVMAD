//
//  Workouts.swift
//  Lab 5 Extra Credit
//
//  Created by Alejandro Alvarez on 3/19/18.
//  Copyright © 2018 Alejandro Alvarez. All rights reserved.
//

import Foundation
import RealmSwift

class Workouts: Object {
    @objc dynamic var name = ""
    @objc dynamic var completed = false
}
