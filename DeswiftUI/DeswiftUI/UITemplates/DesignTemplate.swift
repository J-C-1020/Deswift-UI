//
//  DesignTemplate.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 12/11/25.
//

import SwiftUI
import Foundation
import Combine

struct element: Identifiable {
    var id = UUID()
    var image: String
    var quote: String
}

enum EditableElement {
    case image(ImageConfig)
    case text(TextConfig)
    case button(ButtonConfig)
    case list(ListConfig)
}


var listElements: [element] = [
    element(image: "WaterDuck", quote: "Water bender"),
    element(image: "FireDuck", quote: "Fire bender"),
    element(image: "EarthDuck", quote: "Earth bender"),
    element(image: "AirDuck", quote: "Air bender")
]


// declaration of the style of this view
class DesignTemplateConfig: ObservableObject {
    
    // image 1 config
    @Published var image1: ImageConfig = ImageConfig(padding: 0, cornerRadius: 20, scaling: .fill, frameWidth: 250, frameHeight: 250, clipShape: "rounded", shadow: 20)
    
    // text 1 config
    @Published var text1: TextConfig = TextConfig(fontWeight: .bold, textStyle: .title, color: .black)
    
    // text 2 config
    @Published var text2: TextConfig = TextConfig(fontWeight: .regular, textStyle: .title2, color: .red)
    
    // button 1 config
    @Published var button1: ButtonConfig = ButtonConfig(backgroundColor: .gray, cornerRadius: 50, padding: 1, textConfig: TextConfig(fontWeight: .bold, color: .red, paddingTrailing: 4, paddingLeading: 2, paddingTop: 20, paddingBottom: 20), iconConfig: IconConfig(name: "play.fill", color: .red))

    // button 2 config
    @Published var button2: ButtonConfig = ButtonConfig(backgroundColor: .gray, cornerRadius: 50, padding: 1, textConfig: TextConfig(fontWeight: .bold, color: .red, paddingTrailing: 2, paddingLeading: 4, paddingTop: 20, paddingBottom: 20), iconConfig: IconConfig(name: "shuffle", color: .red))
    
    // text 3 config
    @Published var text3: TextConfig = TextConfig(color: .secondary)
    
    // list 1 config
    @Published var list1: ListConfig = ListConfig(backgroundVisibility: .hidden, rowHeight: 0, cornerRadius: 0, spacing: 0, listStyle: "plain", textConfig: TextConfig(), imageConfig: ImageConfig(cornerRadius: 4, scaling: .fill, frameWidth: 30, frameHeight: 30, clipShape: "rounded"), iconConfig: IconConfig(name: "ellipsis", frameWidth: 30, frameHeight: 30))
}

struct DesignTemplate: View {
    @ObservedObject var designConfig = DesignTemplateConfig()
    @Binding var selectedElement: EditableElement?
    @Binding var showEditor: Bool
    
    var body: some View {
        VStack{
            VStack {
                HStack{
                    Spacer()
                    
                    // image 1
                    Image("duck")
                        .resizable()
                        .modifier(ImageConfigurationModifier(config: designConfig.image1))
                        .onTapGesture {
                            selectedElement = .image(designConfig.image1)
                            showEditor = true
                        }
                    Spacer()
                }
                .padding()
                
                // text 1
                Text("Duck Energy")
                    .applyConfig(designConfig.text1) // Apply all styling from config
                    .padding(.trailing, designConfig.text1.paddingTrailing)
                    .padding(.leading, designConfig.text1.paddingLeading)
                    .padding(.top, designConfig.text1.paddingTop)
                    .padding(.bottom, designConfig.text1.paddingBottom)
                    .onTapGesture {
                        selectedElement = .text(designConfig.text1)
                        showEditor = true
                    }
                
                // text2
                Text("Good Day Elements")
                    .applyConfig(designConfig.text2)
                    .padding(.trailing, designConfig.text2.paddingTrailing)
                    .padding(.leading, designConfig.text2.paddingLeading)
                    .padding(.top, designConfig.text2.paddingTop)
                    .padding(.bottom, designConfig.text2.paddingBottom)
                    .onTapGesture {
                        selectedElement = .text(designConfig.text2)
                        showEditor = true
                    }
                
                HStack{
                    // button 1
                    Button {
                        selectedElement = .button(designConfig.button1)
                        showEditor = true

                    } label: {
                        HStack{
                            Spacer()
                            Image(systemName: designConfig.button1.iconConfig.name)
                                .iconConfig(designConfig.button1.iconConfig)
                                .padding(2)
                                .padding(.trailing, 2)
                            Text("Play")
                                .applyConfig(designConfig.button1.textConfig)
                                .padding(.trailing, designConfig.button1.textConfig.paddingTrailing)
                                .padding(.leading, designConfig.button1.textConfig.paddingLeading)
                                .padding(.top, designConfig.button1.textConfig.paddingTop)
                                .padding(.bottom, designConfig.button1.textConfig.paddingBottom)
                            Spacer()
                        }.foregroundStyle(.red)
                        .background {
                            RoundedRectangle(cornerRadius: designConfig.button1.cornerRadius)
                                .foregroundStyle(designConfig.button1.backgroundColor)
                                .opacity(0.2)
                        }
                        .padding(designConfig.button1.padding)
                        
                    }
                    
                    // button 2
                    Button {
                        selectedElement = .button(designConfig.button2)
                        showEditor = true
                    } label: {
                        HStack{
                            Spacer()
                            Image(systemName: designConfig.button2.iconConfig.name)
                                .iconConfig(designConfig.button2.iconConfig)
                                .padding(2)
                                .padding(.trailing, 2)
                            Text("Shuffle")
                                .applyConfig(designConfig.button2.textConfig)
                                .padding(.trailing, designConfig.button2.textConfig.paddingTrailing)
                                .padding(.leading, designConfig.button2.textConfig.paddingLeading)
                                .padding(.top, designConfig.button2.textConfig.paddingTop)
                                .padding(.bottom, designConfig.button2.textConfig.paddingBottom)
                            Spacer()
                        }.foregroundStyle(.red)
                        .background {
                            RoundedRectangle(cornerRadius: designConfig.button2.cornerRadius)
                                .foregroundStyle(designConfig.button2.backgroundColor)
                                .opacity(0.2)
                        }
                        .padding(.trailing, 5)
                        .padding(.leading, 1)
                    }
                }
                .padding()
                .shadow(radius: 20)
                
                // text 3
                Text("Duck elements for having your day full of good energy and wisdom ...")
                    .applyConfig(designConfig.text3)
                    .padding(.trailing, designConfig.text3.paddingTrailing)
                    .padding(.leading, designConfig.text3.paddingLeading)
                    .padding(.top, designConfig.text3.paddingTop)
                    .padding(.bottom, designConfig.text3.paddingBottom)
                    .onTapGesture{
                        selectedElement = .text(designConfig.text3)
                        showEditor = true
                    }
                
                Divider()
                
                // list 1
                List{
                    ForEach(listElements){element in
                        HStack{
                            Image(element.image)
                                .resizable()
                                .modifier(ImageConfigurationModifier(config: designConfig.list1.imageConfig))
                            Text(element.quote)
                                .applyConfig(designConfig.list1.textConfig)
                                .padding(.trailing, designConfig.list1.textConfig.paddingTrailing)
                                .padding(.leading, designConfig.list1.textConfig.paddingLeading)
                                .padding(.top, designConfig.list1.textConfig.paddingTop)
                                .padding(.bottom, designConfig.list1.textConfig.paddingBottom)
                            Spacer()
                            Image(systemName: designConfig.list1.iconConfig.name)
                                .padding(.trailing)
                                .iconConfig(designConfig.list1.iconConfig)
                        }
                        .frame(height: designConfig.list1.rowHeight)
                        .padding(.vertical, designConfig.list1.spacing)
                        .onTapGesture {
                            selectedElement = .list(designConfig.list1)
                            showEditor = true
                        }
                        
                    }
                }
                .applyStyle(styleString: designConfig.list1.listStyle)
                    .modifier(ListConfigurationModifier(config: designConfig.list1))
            }
        }
    }
}

var imageConfig: ImageConfig = ImageConfig()

#Preview {
    DesignTemplate(selectedElement: .constant(.image(imageConfig)), showEditor: .constant(false))
}
