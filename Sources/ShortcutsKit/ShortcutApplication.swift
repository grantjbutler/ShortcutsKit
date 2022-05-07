//
//  File.swift
//  
//
//  Created by Grant Butler on 5/7/22.
//

import ScriptingBridge

struct ShortcutApplication {
    let application: SBApplication
    
    init(_ application: SBApplication) {
        self.application = application
    }
    
    var shortcuts: [Shortcut] {
        guard let array = application.value(forKey: "shortcuts") as? SBElementArray else { return [] }
        return array.map { object in Shortcut(object as! SBObject) }
    }
    
    var folders: [ShortcutFolder] {
        guard let elementArray = application.value(forKey: "folders") as? SBElementArray else { return [] }
        return elementArray.map { object in ShortcutFolder(object as! SBObject) }
    }
    
    func shortcut(withID id: String) -> Shortcut? {
        guard let elementArray = application.value(forKey: "shortcuts") as? SBElementArray else { return nil }
        guard let object = elementArray.object(withID: id) as? SBObject else { return nil }
        return Shortcut(object)
    }
}
