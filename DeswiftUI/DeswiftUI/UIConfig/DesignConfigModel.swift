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
    @Published var padding: CGFloat
    @Published var cornerRadius: CGFloat
    @Published var scaling: ImageScaling
    @Published var frameWidth: CGFloat?
    @Published var frameHeight: CGFloat?
    @Published var clipShape: String?
    @Published var shadow: CGFloat?

    init(padding: CGFloat = 8,
         cornerRadius: CGFloat = 8,
         scaling: ImageScaling = .fill,
         frameWidth: CGFloat? = nil,
         frameHeight: CGFloat? = nil,
         clipShape: String? = "containerRelative",
         shadow: CGFloat? = 0) {
        
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.scaling = scaling
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.clipShape = clipShape
        self.shadow = shadow
    }
}

final class TextConfig: ObservableObject {
    @Published var fontWeight: Font.Weight
    @Published var textStyle: Font.TextStyle?
    @Published var color: Color
    @Published var padding: CGFloat = 0
    
    init(fontWeight: Font.Weight = .regular,
         textStyle: Font.TextStyle? = nil,
         color: Color = .primary,
         padding: CGFloat = 0) {
        self.fontWeight = fontWeight
        self.textStyle = textStyle
        self.color = color
        self.padding = padding
    }
}

final class ButtonConfig: ObservableObject {
    @Published var backgroundColor: Color
    @Published var cornerRadius: CGFloat
    @Published var padding: CGFloat
    @Published var textConfig: TextConfig
    @Published var iconConfig: IconConfig
    
    init(backgroundColor: Color = .blue,
         cornerRadius: CGFloat = 8,
         padding: CGFloat = 12,
         textConfig: TextConfig = TextConfig(),
         iconConfig: IconConfig = IconConfig()) {
        
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.textConfig = textConfig
        self.iconConfig = iconConfig
    }
}


final class ListConfig: ObservableObject {
    @Published var backgroundVisibility: Visibility = .visible
    @Published var rowHeight: CGFloat?
    @Published var cornerRadius: CGFloat
    @Published var spacing: CGFloat
    @Published var listStyle: String
    @Published var textConfig: TextConfig
    @Published var imageConfig: ImageConfig
    @Published var iconConfig: IconConfig
    
    init(backgroundVisibility: Visibility = .hidden,
         rowHeight: CGFloat? = nil,
         cornerRadius: CGFloat = 0,
         spacing: CGFloat = 0,
         listStyle: String = "plain",
         textConfig: TextConfig = TextConfig(),
         imageConfig: ImageConfig = ImageConfig(),
         iconConfig: IconConfig = IconConfig()) {
        
        self.backgroundVisibility = backgroundVisibility
        self.rowHeight = rowHeight
        self.cornerRadius = cornerRadius
        self.spacing = spacing
        self.listStyle = listStyle
        self.textConfig = textConfig
        self.imageConfig = imageConfig
        self.iconConfig = iconConfig
    }
}

