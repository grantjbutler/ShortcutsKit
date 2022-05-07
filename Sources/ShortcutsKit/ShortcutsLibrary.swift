//
//  ShortcutsLibrary.swift
//  
//
//  Created by Grant Butler on 5/6/22.
//

import ScriptingBridge

public final class ShortcutsLibrary {
    public static let `default` = ShortcutsLibrary()
    
    public static var hasShortcutsLibrary: Bool {
        return SBApplication(bundleIdentifier: "com.apple.Shortcuts") != nil
    }
    
    private let application: SBApplication
    
    private init() {
        self.application = SBApplication(bundleIdentifier: "com.apple.Shortcuts")!
    }
    
    public var shortcuts: [Shortcut] {
        guard let array = application.value(forKey: "shortcuts") as? SBElementArray else { return [] }
        return array.map { object in Shortcut(object as! SBObject) }
    }
    
    public var folders: [ShortcutFolder] {
        guard let elementArray = application.value(forKey: "folders") as? SBElementArray else { return [] }
        return elementArray.map { object in ShortcutFolder(object as! SBObject) }
    }
    
    public func shortcut(withID id: String) -> Shortcut? {
        guard let elementArray = application.value(forKey: "shortcuts") as? SBElementArray else { return nil }
        guard let object = elementArray.object(withID: id) as? SBObject else { return nil }
        return Shortcut(object)
    }
}
