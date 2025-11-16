//
//  EditorViews.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 13/11/25.
//

import SwiftUI
import Foundation
import Combine


struct ClipShapeModifier: ViewModifier {
    let shape: String?
    
    func body(content: Content) -> some View {
        switch shape {
        case "circle":
            content.clipShape(Circle())
        case "rounded":
            content.clipShape(RoundedRectangle(cornerRadius: 12))
        case "containerRelative":
            content.clipShape(.containerRelative)
        default:
            content
        }
    }
}

struct CustomSlider: View {
    let title: String
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    let step: CGFloat
    let displayAsInteger: Bool
    
    init(title: String, value: Binding<CGFloat>, range: ClosedRange<CGFloat>, step: CGFloat = 1, displayAsInteger: Bool = true) {
        
        self.title = title
        self._value = value
        self.range = range
        self.step = step
        self.displayAsInteger = displayAsInteger
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text(title)
                Spacer()
                if displayAsInteger {
                    Text("\(Int(value))")
                        .font(.callout)
                        .bold()
                } else {
                    Text(String(format: "%.2f", value))
                        .font(.callout)
                        .bold()
                }
            }
            
            Slider(value: $value, in: range, step: step)
        }
    }
}

// converts optional bindings to zero
extension Binding where Value == CGFloat? {
    func unwrapped(defaultValue: CGFloat = 0) -> Binding<CGFloat> {
        return Binding<CGFloat>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

struct IconEditorView: View {
    @ObservedObject var config: IconConfig
    
    // for now, keep the icons available really simple
    let suggestedIcons = ["play.fill", "shuffle", "ellipsis", "star.fill", "heart.fill", "person.fill", "bolt.fill", "bell.fill", "house.fill"]

    var body: some View {
        Group {
            
            Section("Icon Selection & Preview") {
                HStack {
                    Spacer()
                    Image(systemName: config.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .opacity(config.opacity)
                        .padding(.leading, 5)
                    Spacer()
                }
                .padding(.vertical)
                
                Picker("SF Symbol", selection: $config.name) {
                    ForEach(suggestedIcons, id: \.self) { iconName in
                            Image(systemName: iconName)
                        .tag(iconName)
                    }
                }
                .foregroundColor(config.color)
                .pickerStyle(.palette)
            }
            
            Section("Appearance") {
                ColorPicker("Icon Color", selection: $config.color)
                                
                CustomSlider(title: "Opacity",
                    value: Binding<CGFloat>(
                        get: { CGFloat(config.opacity) },
                        set: { config.opacity = Double($0) }
                    ),
                    range: 0...1,
                    step: 0.05,
                    displayAsInteger: false
                )
            }
            
            Section("Frame & Spacing") {
                Stepper("Padding: \(Int(config.padding))",
                        value: $config.padding, in: 0...50)
                
                CustomSlider(title: "Frame Width", value: $config.frameWidth.unwrapped(defaultValue: 0), range: 0...300)
                
                CustomSlider(title: "Frame Height", value: $config.frameHeight.unwrapped(defaultValue: 0), range: 0...300)
            }
        }
    }
}

struct ImageEditorView: View {
    @ObservedObject var config: ImageConfig
    let clipShapes = [
        "none",
        "circle",
        "rounded",
        "containerRelative"
    ]

    
    var body: some View {
        NavigationView{
            Form {
                Section("Frame") {
                    CustomSlider(title: "Corner Radius",value: $config.cornerRadius,range: 0...50)
                    
                    CustomSlider(title: "Height",value: $config.frameHeight.unwrapped(defaultValue: 0),range: 0...300)

                    CustomSlider(title: "Width",value: $config.frameWidth.unwrapped(defaultValue: 0),range: 0...300)


                    Stepper("Padding: \(Int(config.padding))",
                            value: $config.padding, in: 0...50)
                }
                
                Section("Shadow") {
                    CustomSlider(title: "Shadow",value: $config.shadow.unwrapped(defaultValue: 0),range: 0...30)
                }

                
                Section("Scaling") {
                    Picker("Scaling", selection: $config.scaling) {
                        Text("Fit").tag(ImageScaling.fit)
                        Text("Fill").tag(ImageScaling.fill)
                    }
                    .pickerStyle(.segmented)
                }

                
                Section("Clip Shape") {
                    Picker("Clip Shape", selection: $config.clipShape) {
                        ForEach(clipShapes, id: \.self) { shape in
                            Text(shape.capitalized).tag(shape as String?)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Edit Image")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }
}

struct TextEditorView: View {
    @ObservedObject var config: TextConfig
        
    let weights: [(String, Font.Weight)] = [
        ("UltraLight", .ultraLight),
        ("Thin", .thin),
        ("Light", .light),
        ("Regular", .regular),
        ("Medium", .medium),
        ("Semibold", .semibold),
        ("Bold", .bold),
        ("Heavy", .heavy),
        ("Black", .black)
    ]
    
    let textStyles: [(String, Font.TextStyle?)] = [
        ("None", nil),
        ("Large Title", .largeTitle),
        ("Title", .title),
        ("Title 2", .title2),
        ("Title 3", .title3),
        ("Headline", .headline),
        ("Body", .body),
        ("Subheadline", .subheadline),
        ("Callout", .callout),
        ("Footnote", .footnote),
        ("Caption", .caption),
        ("Caption 2", .caption2)
    ]

    var body: some View {
            NavigationView {
                Form {
                    Section("System Text Style") {
                        Picker("Style", selection: $config.textStyle) {
                            ForEach(textStyles, id: \.0) { name, style in                                                Text(name).tag(style)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Font Weight") {
                        Picker("Weight", selection: $config.fontWeight) {
                            ForEach(weights, id: \.1) { name, weight in
                                Text(name).tag(weight)
                            }
                        }
                    }
                    
                    
                    Section("Color") {
                        ColorPicker("Text Color", selection: $config.color)
                    }
                    
                    
                    Section("Padding") {
                        Stepper("Padding Top: \(Int(config.paddingTop))",
                                value: $config.paddingTop, in: 0...50)
                        
                        Stepper("Padding Bottom: \(Int(config.paddingBottom))",
                                value: $config.paddingBottom, in: 0...50)
                        
                        Stepper("Padding Leading: \(Int(config.paddingLeading))",
                                value: $config.paddingLeading, in: 0...50)
                        
                        Stepper("Padding Trailing: \(Int(config.paddingTrailing))",
                                value: $config.paddingTrailing, in: 0...50)
                    }
                }
                .navigationTitle("Edit Text")
                .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.medium, .large])
        }
}

struct ButtonEditorView: View {
    @ObservedObject var config: ButtonConfig
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("Background & Shape") {
                    ColorPicker("Background Color", selection: $config.backgroundColor)
                    
                    CustomSlider(title: "Corner Radius",value: $config.cornerRadius,range: 0...50)
                    
                    Stepper("Padding: \(Int(config.padding))",
                            value: $config.padding, in: 0...50)
                }
                
                IconEditorView(config: config.iconConfig)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
                
                TextEditorView(config: config.textConfig)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
                
            }
            .navigationTitle("Edit Button")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }
}

struct ListEditorView: View {
    @ObservedObject var config: ListConfig
    
    let listStyles = ["plain", "grouped", "insetGrouped", "sidebar"] // list styles
    let backgroundVisibilities: [(String, Visibility)] = [
        ("Hidden", .hidden),
        ("Visible", .visible),
    ]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("List Style") {
                    Picker("List Style", selection: $config.listStyle) {
                        ForEach(listStyles, id: \.self) { style in
                            Text(style.capitalized).tag(style)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Visibility", selection: $config.backgroundVisibility) {
                        ForEach(backgroundVisibilities, id: \.0) { name, visibility in
                            Text(name).tag(visibility)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Row") {
                    CustomSlider(title: "Corner Radius",value: $config.cornerRadius,range: 0...50)
                    
                    CustomSlider(title: "Row Spacing",value: $config.spacing,range: 0...50)
                                        
                    CustomSlider(title: "Row Height",value: $config.rowHeight.unwrapped(defaultValue: 20),range: 20...200)
                }
                
                IconEditorView(config: config.iconConfig)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
                
                TextEditorView(config: config.textConfig)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)

                ImageEditorView(config: config.imageConfig)
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
            }
            .navigationTitle("Edit List")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }
}

