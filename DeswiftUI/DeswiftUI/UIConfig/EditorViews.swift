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
    
    init(title: String, value: Binding<CGFloat>, range: ClosedRange<CGFloat>, step: CGFloat = 1) {
        
        self.title = title
        self._value = value
        self.range = range
        self.step = step
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text(title)
                Spacer()
                Text("\(Int(value))")
                    .font(.callout)
                    .bold()
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
                        Stepper("Padding: \(Int(config.padding))",
                                value: $config.padding, in: 0...50)
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
                
                Section("Icon") {
                    ColorPicker("Icon Color", selection: $config.iconConfig.color)
                    
                    CustomSlider(title: "Icon Size",value: $config.iconConfig.size,range: 8...100)
                    
                    Stepper("Icon Padding: \(Int(config.iconConfig.padding))",
                            value: $config.iconConfig.padding, in: 0...50)
                    
                    TextField("Icon Name (SF Symbol)", text: $config.iconConfig.name)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                                        
                    CustomSlider(title: "Icon Opacity",
                        value: Binding<CGFloat>(
                            get: { CGFloat(config.iconConfig.opacity) }, // convert value for slider
                            set: { config.iconConfig.opacity = Double($0) } // reconvert for latter usage
                    ), range: 0...1)
                }
                
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
    let backgroundVisibilities = ["automatic", "hidden", "visible"]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("Background & Row") {
                    
                    Picker("Background Visibility", selection: $config.backgroundVisibility) {
                        ForEach(backgroundVisibilities, id: \.self) { visibility in
                            Text(visibility.capitalized).tag(visibility)
                        }
                    }
                    
                    CustomSlider(title: "Corner Radius",value: $config.cornerRadius,range: 0...50)
                    
                    CustomSlider(title: "Row Spacing",value: $config.spacing,range: 0...50)
                                        
                    CustomSlider(title: "Row Height",value: $config.rowHeight.unwrapped(defaultValue: 20),range: 20...200)
                }
                
                Section("List Style") {
                    Picker("List Style", selection: $config.listStyle) {
                        ForEach(listStyles, id: \.self) { style in
                            Text(style.capitalized).tag(style)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Icon") {
                    VStack {
                        ColorPicker("Icon Color", selection: $config.iconConfig.color)
                        
                        CustomSlider(title: "Icon Size",value: $config.iconConfig.size,range: 8...100)
                        
                        Stepper("Icon Padding: \(Int(config.iconConfig.padding))",
                                value: $config.iconConfig.padding, in: 0...50)
                        
                        TextField("Icon Name (SF Symbol)", text: $config.iconConfig.name)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        CustomSlider(title: "Icon Opacity",
                            value: Binding<CGFloat>(
                                get: { CGFloat(config.iconConfig.opacity) }, // convert value for slider
                                set: { config.iconConfig.opacity = Double($0) } // reconvert for latter usage
                        ), range: 0...1)
                    }
                }
                
                
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

