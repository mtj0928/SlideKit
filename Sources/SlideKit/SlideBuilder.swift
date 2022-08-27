//
//  SlideBuilder.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

@resultBuilder
public struct SlideBuilder {
    public static func buildBlock(_ components: any Slide...) -> [any Slide] {
        components.map { $0 }
    }
}
