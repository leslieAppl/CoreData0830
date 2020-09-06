//
//  Mood.swift
//  CoreData0830
//
//  Created by leslie on 8/31/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import Foundation
import CoreData
///Protocol notes:
///The abstract definition(declaration) of the properties and methods in the Protocol are common processes to all of the classes which confirmed the protocol!!
///We can override these Protocol's properties and methods with detailed definition  in a certain class which confirmed the protocol. These  detailed overriding are specific process only for the class itself.
///We can also override them with detailed definition in the Protocol extension. They are common processes.
///Override in the Class is primitive to the Protocol.

/// When meet the constraint on the extension Managed where Self: NSManagedObject {} protocol extension
extension Mood: Managed {
//    @NSManaged fileprivate(set) var date: Date
//    @NSManaged fileprivate(set) var colors: [UIColor]
    
    ///Override declaration 2 in the 'Managed' Protocol angain to put Mood's sort descriptor in.
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}

