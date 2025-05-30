//
//  CustomHeaderStyleSlide.swift
//  SlideKitDemo-macOS
//
//  Created by Junnosuke Matsumoto on 2022/09/17.
//

import SlideKit
import SwiftUI

@Slide
struct CustomHeaderStyleSlide: View {
    var body: some View {
        HeaderSlide("Custom Style Slide") {
            Item("Header Slide Style") {
                Item("You can customize the layout of HeaderSlide by HeaderSlideStyle")
            }
            Item("Item Style") {
                Item("You can also customize the design of Item by ItemStyle")
            }
        }
        .headerSlideStyle(CustomHeaderStyle())
        .itemStyle(CustomItemStyle())
    }

    var backwardTransition: AnyTransition {
        .push(from: .leading)
    }

    var forwardTransition: AnyTransition {
        .push(from: .trailing)
    }
}

struct CustomHeaderStyle: HeaderSlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.header
                .font(.system(size: 90))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    Color.accentColor
                }
            VStack(alignment: .leading, spacing: 48) {
                configuration.content
                    .font(.system(size: 48))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CustomItemStyle: ItemStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Group {
                    switch configuration.accessory {
                    case .bullet:
                        let text: String = (0..<configuration.itemDepth).reduce("#", { result, _ in result + "#" })
                        Text(text)
                            .fontWeight(.semibold)
                    case .string(let text):
                        Text("\(text).")
                            .fontWeight(.semibold)
                    case .number(let number):
                        Text("\(number).")
                    case nil: EmptyView()
                    }
                }

                configuration.label
                    .fixedSize()
            }


            if let child = configuration.child {
                child.padding(.leading)
            }
        }
    }
}

struct CustomHeaderStyleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CustomHeaderStyleSlide()
        }
    }
}
