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
                    Slider(
                        value: Binding(
                            get: { Double(config.cornerRadius) },
                            set: { config.cornerRadius = CGFloat($0) }
                        ),
                        in: 0...50
                    ) {
                        Text("Corner Radius")
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.frameHeight ?? 0) },
                            set: { config.frameHeight = CGFloat($0) }
                        ),
                        in: 0...300
                    ) {
                        Text("Height")
                    }

                    
                    Slider(
                        value: Binding(
                            get: { Double(config.frameWidth ?? 0) },
                            set: { config.frameWidth = CGFloat($0) }
                        ),
                        in: 0...300
                    ) {
                        Text("Width")
                    }


                    Stepper("Padding: \(Int(config.padding))",
                            value: $config.padding, in: 0...50)
                }
                
                Section("Shadow") {
                    Slider(value: Binding($config.shadow)!, in: 0...30) {
                        Text("Shadow")
                    }
                }
                
                Section("Resizable") {
                    Toggle("Resizable", isOn: $config.resizable)
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

    var body: some View {
            NavigationView {
                Form {
                    Section("Font Size") {
                        Slider(value: $config.fontSize.double, in: 8...72) {
                            Text("Font Size")
                        }
                        Text("Size: \(Int(config.fontSize))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Section("Font Weight") {
                        Picker("Weight", selection: $config.fontWeight) {
                            ForEach(weights, id: \.1) { name, weight in
                                Text(name).tag(weight)
                            }
                        }
                    }
                    
                    Section("Style") {
                        Toggle("Bold", isOn: $config.bold)
                        Toggle("Italic", isOn: $config.italic)
                        Toggle("Underline", isOn: $config.underlined)
                    }
                    
                    
                    Section("Color") {
                        ColorPicker("Text Color", selection: $config.color)
                    }
                    
                    
                    Section("Padding") {
                        Slider(value: $config.padding.double, in: 0...40) {
                            Text("Padding")
                        }
                        Text("Padding: \(Int(config.padding))")
                            .font(.caption)
                            .foregroundColor(.secondary)
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

    /*@Published var backgroundColor: Color = .blue
     @Published var cornerRadius: CGFloat = 8
     @Published var padding: CGFloat = 12
     @Published var textConfig: TextConfig = TextConfig()
     @Published var iconConfig: IconConfig = IconConfig()*/
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("Background & Shape") {
                    ColorPicker("Background Color", selection: $config.backgroundColor)
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.cornerRadius) },
                            set: { config.cornerRadius = CGFloat($0) }
                        ),
                        in: 0...50
                    ) {
                        Text("Corner Radius")
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.padding) },
                            set: { config.padding = CGFloat($0) }
                        ),
                        in: 0...50
                    ) {
                        Text("Padding")
                    }
                }
                
                Section("Icon") {
                    ColorPicker("Icon Color", selection: $config.iconConfig.color)
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.iconConfig.size) },
                            set: { config.iconConfig.size = CGFloat($0) }
                        ),
                        in: 8...100
                    ) {
                        Text("Icon Size")
                    }
                    
                    Stepper("Icon Padding: \(Int(config.iconConfig.padding))",
                            value: $config.iconConfig.padding, in: 0...50)
                    
                    TextField("Icon Name (SF Symbol)", text: $config.iconConfig.name)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    Slider(
                        value: $config.iconConfig.opacity,
                        in: 0...1
                    ) {
                        Text("Icon Opacity")
                    }
                }
                
                Section("Text") {
                    TextEditorView(config: config.textConfig)
                        .frame(height: 300)
                }
                
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
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("Background & Row") {
                    ColorPicker("Background Color", selection: $config.backgroundColor)
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.cornerRadius) },
                            set: { config.cornerRadius = CGFloat($0) }
                        ),
                        in: 0...50
                    ) {
                        Text("Corner Radius")
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.spacing) },
                            set: { config.spacing = CGFloat($0) }
                        ),
                        in: 0...50
                    ) {
                        Text("Row Spacing")
                    }
                    
                    Slider(
                        value: Binding(
                            get: { Double(config.rowHeight ?? 0) },
                            set: { config.rowHeight = CGFloat($0) }
                        ),
                        in: 20...200
                    ) {
                        Text("Row Height")
                    }
                }
                
                Section("List Style") {
                    Picker("List Style", selection: $config.listStyle) {
                        ForEach(listStyles, id: \.self) { style in
                            Text(style.capitalized).tag(style)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Text") {
                    TextEditorView(config: config.textConfig)
                        .frame(height: 200)
                }
                
                Section("Image") {
                    ImageEditorView(config: config.imageConfig)
                        .frame(height: 300)
                }
                
                Section("Icon") {
                    VStack {
                        ColorPicker("Icon Color", selection: $config.iconConfig.color)
                        
                        Slider(
                            value: Binding(
                                get: { Double(config.iconConfig.size) },
                                set: { config.iconConfig.size = CGFloat($0) }
                            ),
                            in: 8...100
                        ) {
                            Text("Icon Size")
                        }
                        
                        Stepper("Icon Padding: \(Int(config.iconConfig.padding))",
                                value: $config.iconConfig.padding, in: 0...50)
                        
                        TextField("Icon Name (SF Symbol)", text: $config.iconConfig.name)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        Slider(
                            value: $config.iconConfig.opacity,
                            in: 0...1
                        ) {
                            Text("Icon Opacity")
                        }
                    }
                }
            }
            .navigationTitle("Edit List")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium, .large])
    }
}


// binder to help unwrapp double to cgfloat for ui elements
extension Binding where Value == CGFloat {
    var double: Binding<Double> {
        Binding<Double>(
            get: { Double(self.wrappedValue) },
            set: { self.wrappedValue = CGFloat($0) }
        )
    }
}
