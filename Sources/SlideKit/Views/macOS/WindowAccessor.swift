//
//  File.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/31.
//

#if os(macOS)
import AppKit
import Foundation
import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    let completion: (NSWindow?) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            completion(view.window)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

extension View {
    public func configureWindow(_ completion: @escaping (NSWindow?) -> Void) -> some View {
        self.background(WindowAccessor(completion: completion))
    }
}
#endif
