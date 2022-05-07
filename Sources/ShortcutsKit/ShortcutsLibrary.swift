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
    
    private let application: ShortcutApplication
    private let eventsApplication: ShortcutApplication
    
    private init() {
        self.application = ShortcutApplication(SBApplication(bundleIdentifier: "com.apple.Shortcuts")!)
        self.eventsApplication = ShortcutApplication(SBApplication(bundleIdentifier: "com.apple.shortcuts.events")!)
    }
    
    public var shortcuts: [Shortcut] { application.shortcuts }
    
    public var folders: [ShortcutFolder] { application.folders }
    
    public func shortcut(withID id: String) -> Shortcut? { application.shortcut(withID: id) }
    
    func run(_ shortcut: Shortcut, inBackground: Bool) {
        let app = inBackground ? eventsApplication : application
        guard let target = app.shortcut(withID: shortcut.id) else { fatalError() }
        target.run()
    }
}
