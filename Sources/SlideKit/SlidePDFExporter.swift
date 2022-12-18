//
//  SlidePDFExporter.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/12/18.
//

#if os(macOS)
import SwiftUI

@available(macOS 13.0, *)
@MainActor
public enum SlidePDFExporter {
    /// Exports a PDF file from the given ``SlideIndexController`` and `View`.
    ///
    /// > Warning: The API supports only SwiftUI view, and if the view has UIKit components or AppKit components, they are not included into the PDF.
    /// - Parameters:
    ///   - view: The target View.
    ///   - slideIndexController: A ``SlideIndexController``.
    ///   - slideSize: A size of the PDF.
    public static func export(
        view: some View,
        with slideIndexController: SlideIndexController,
        size slideSize: CGSize
    ) {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.pdf]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.begin { response in
            guard response == .OK,
                  let filePath = savePanel.url
            else { return }

            var mediaBox = CGRect(origin: .zero, size: slideSize)

            guard let consumer = CGDataConsumer(url: filePath as CFURL),
                  let pdfContext = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
            else {
                print("failed")
                return
            }

            slideIndexController.backToFirst()
            repeat {
                let renderer = ImageRenderer(content: view.frame(width: slideSize.width, height: slideSize.height))
                renderer.render { size, renderer in
                    let options: [CFString: Any] = [
                        kCGPDFContextMediaBox: CGRect(origin: .zero, size: size )
                    ]
                    pdfContext.beginPDFPage(options as CFDictionary)
                    renderer(pdfContext)
                    pdfContext.endPDFPage()
                }
            } while slideIndexController.forward()

            pdfContext.closePDF()
        }
    }
}
#endif
