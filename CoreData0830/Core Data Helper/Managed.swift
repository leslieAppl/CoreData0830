//
//  Managed.swift
//  CoreData0830
//
//  Created by leslie on 8/31/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import Foundation
import CoreData

/// Managed: class (Class-Only Protocols - assumes or requires that a conforming type has reference semantics rather than value semantics.)
///
///Protocol notes:
///The abstract definition(declaration) of the properties and methods in the Protocol are common processes to all of the classes which confirmed the protocol!!
///We can override these Protocol's properties and methods with detailed definition  in a certain class which confirmed the protocol. These  detailed overriding are specific process only for the class itself.
///We can also override them with detailed definition in the Protocol extension. They are common processes.
///Override in the Class is primitive to the Protocol.

protocol Managed: class, NSFetchRequestResult {
    
    static var entityName: String { get }   //declare 1
    static var defaultSortDescriptors: [NSSortDescriptor] { get }   //d2
    
}

extension Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] { return [] }     //o2
    
    ///Fetch request Illustation:
    ///If a data model - a subclass of MSManagedObject want to call this static computed property, it will do two things.
    ///1, It will call entityName property which will fetch the entity name from the data model object to the receiver itself to init the NSFetchRequest instance.
    ///Note: NSFetchRequest<Self> means the caller - data model itself.
    ///2, And it will also assign the defaultSortDescriptoers property which has been overrided in the data model itslef(in this example, the Mood Entity's NSManagedObject subclass) to the request's sortDescriptors property.
    static var sortedFetchRequest: NSFetchRequest<Self> {   //d3
        
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
        
    }
}

extension Managed where Self: NSManagedObject {
    
    static var entityName: String {     //override 1
        return entity().name!
    }
    
}



