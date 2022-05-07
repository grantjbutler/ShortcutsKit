//
//  ShortcutFolder.swift
//  
//
//  Created by Grant Butler on 5/7/22.
//

import ScriptingBridge

public struct ShortcutFolder {
    let object: SBObject
    
    init(_ object: SBObject) {
        self.object = object
    }
    
    public var name: String {
        return object.value(forKey: "name") as! String
    }
    
    public var id: String {
        return object.value(forKey: "id") as! String
    }
    
    public var shortcuts: [Shortcut] {
        guard let elementArray = object.value(forKey: "shortcutes") as? SBElementArray else { return [] }
        return elementArray.map { object in Shortcut(object as! SBObject) }
    }
}
