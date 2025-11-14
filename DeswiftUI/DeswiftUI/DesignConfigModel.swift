//
//  DesignConfigModel.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 13/11/25.
//

import SwiftUI
import Foundation
import Combine

// model declaration of UI variables
final class IconConfig: ObservableObject {
    @Published var name: String = "person.fill"
    @Published var color: Color = .blue
    @Published var size: CGFloat = 24
    @Published var padding: CGFloat = 8
    @Published var frameWidth: CGFloat? = nil
    @Published var frameHeight: CGFloat? = nil
    @Published var opacity: Double = 1.0
}

enum ImageScaling: String, CaseIterable, Identifiable {
    case fit
    case fill
    
    var id: String { rawValue }
}


final class ImageConfig: ObservableObject {
    @Published var padding: CGFloat = 8
    @Published var cornerRadius: CGFloat = 8
    @Published var resizable: Bool = true
    @Published var scaling: ImageScaling = .fill
    @Published var frameWidth: CGFloat? = nil
    @Published var frameHeight: CGFloat? = nil
    @Published var clipShape: String? = "containerRelative"
    @Published var shadow: CGFloat? = 0
}

final class TextConfig: ObservableObject {
    @Published var fontSize: CGFloat = 16
    @Published var fontWeight: Font.Weight = .regular
    @Published var color: Color = .primary
    @Published var font: Font? = nil
    @Published var bold: Bool = false
    @Published var italic: Bool = false
    @Published var underlined: Bool = false
    @Published var padding: CGFloat = 5
}

final class ButtonConfig: ObservableObject {
    @Published var backgroundColor: Color = .blue
    @Published var cornerRadius: CGFloat = 8
    @Published var padding: CGFloat = 12
    @Published var textConfig: TextConfig = TextConfig()
    @Published var iconConfig: IconConfig = IconConfig()
}

final class ListConfig: ObservableObject {
    @Published var backgroundColor: Color = .clear
    @Published var rowHeight: CGFloat? = nil
    @Published var cornerRadius: CGFloat = 0
    @Published var spacing: CGFloat = 0
    @Published var listStyle: String = "plain"
    @Published var textConfig: TextConfig = TextConfig()
    @Published var imageConfig: ImageConfig = ImageConfig()
    @Published var iconConfig: IconConfig = IconConfig()
}

class DesignTemplateConfig: ObservableObject {
    @Published var image1: ImageConfig = ImageConfig()
    @Published var text1: TextConfig = TextConfig()
    @Published var text2: TextConfig = TextConfig()
    @Published var button1: ButtonConfig = ButtonConfig()
    @Published var button2: ButtonConfig = ButtonConfig()
    @Published var text3: TextConfig = TextConfig()
    @Published var list1: ListConfig = ListConfig()
    
}
