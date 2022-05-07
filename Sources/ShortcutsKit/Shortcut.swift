//
//  Shortcut.swift
//  
//
//  Created by Grant Butler on 5/6/22.
//

import ScriptingBridge
import AppKit

@objc
private protocol ShortcutActions {
    func runWithInput(_ input: Any?)
}

public struct Shortcut {
    let object: SBObject
    
    init(_ object: SBObject) {
        self.object = object
    }
    
    public var id: String {
        return object.value(forKey: "id") as! String
    }
    
    public var name: String {
        return object.value(forKey: "name") as! String
    }
    
    public var subtitle: String? {
        return object.value(forKey: "subtitle") as? String
    }
    
    public var color: NSColor? {
        return object.value(forKey: "color") as? NSColor
    }
    
    public var icon: NSImage? {
        return object.value(forKey: "icon") as? NSImage
    }
    
    public var acceptsInput: Bool {
        guard let number = object.value(forKey: "acceptsInput") as? NSNumber else { return false }
        return number.boolValue
    }
    
    public var actionCount: Int {
        guard let number = object.value(forKey: "actionCount") as? NSNumber else { return 0 }
        return number.intValue
    }
    
    public var folder: ShortcutFolder? {
        guard let object = object.value(forKey: "folder") as? SBObject else { return nil }
        return ShortcutFolder(object)
    }
    
    public func run() async {
        await withUnsafeContinuation { (continuation: UnsafeContinuation<Void, Never>) in
            DispatchQueue.global(qos: .background).async {
                object.perform(#selector(ShortcutActions.runWithInput(_:)), with: nil)
                continuation.resume(returning: ())
            }
        }
    }
}

extension Shortcut: CustomStringConvertible {
    public var description: String {
        return "<Shortcut \(id): \(name), \(subtitle ?? "")>"
    }
}
