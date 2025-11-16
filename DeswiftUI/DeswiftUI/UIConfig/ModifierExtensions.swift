//
//  ModifierExtensions.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 16/11/25.
//

import SwiftUI

extension Text {
    func applyConfig(_ config: TextConfig) -> Text {
        var configuredText: Text
        
        if let style = config.textStyle {
            configuredText = self.font(.system(style))
                .fontWeight(config.fontWeight)
        } else {
            configuredText = self.font(.body)
                .fontWeight(config.fontWeight)
        }
        
        configuredText = configuredText.foregroundColor(config.color)
        
        return configuredText
    }
}

// extension to do the clipshape and scaling of the image
extension View {
    @ViewBuilder
    func clipView(shape: String?, cornerRadius: CGFloat) -> some View {
        switch shape {
        case "circle":
            self.clipShape(.circle)
        case "rounded":
            self.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        case "containerRelative":
            self.clipShape(.containerRelative)
        case "none", .none:
            self.cornerRadius(cornerRadius)
        default:
            self
        }
    }
    
    @ViewBuilder
    func applyScaling(style: ImageScaling) -> some View {
        if style == .fill {
            self.scaledToFill()
        } else {
            self.scaledToFit()
        }
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ImageConfigurationModifier: ViewModifier {
    @ObservedObject var config: ImageConfig

    func body(content: Content) -> some View {
        content
            .applyScaling(style: config.scaling)
            .frame(width: config.frameWidth, height: config.frameHeight)
            .clipView(shape: config.clipShape, cornerRadius: config.cornerRadius)
            .shadow(radius: config.shadow ?? 0)
            .padding(config.padding)
    }
}

extension List {
    @ViewBuilder
    func applyStyle(styleString: String) -> some View {
        switch styleString {
        case "grouped":
            self.listStyle(GroupedListStyle())
        case "insetGrouped":
            self.listStyle(InsetGroupedListStyle())
        case "sidebar":
            self.listStyle(SidebarListStyle())
        case "plain":
            self.listStyle(PlainListStyle())
        default:
            self.listStyle(DefaultListStyle())
        }
    }
}
struct ListConfigurationModifier: ViewModifier {
    @ObservedObject var config: ListConfig

    func body(content: Content) -> some View {
        content
            .background(config.backgroundColor)
            .cornerRadius(config.cornerRadius)
    }
}
