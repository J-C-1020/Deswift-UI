//
//  DesignTemplate.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 12/11/25.
//

import SwiftUI

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

let heights = [0.25, 0.5, 0.75, 1.0]
let usedHeights = heights.map { PresentationDetent.fraction($0) }

func fraction(from detent: PresentationDetent) -> CGFloat {
    for (index, d) in usedHeights.enumerated() {
        if d == detent {
            print(CGFloat(heights[index]))
            return CGFloat(heights[index])
        }
    }
    return 1.0
}



struct DesignTemplate: View {
    @StateObject var designConfig = DesignTemplateConfig()
    @State private var selectedElement: EditableElement? = nil
    @State private var showEditor = false
    
        
    var body: some View {
        GeometryReader{ geo in

            VStack{
                VStack {
                    HStack{
                        Spacer()
                        Image("duck")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .shadow(radius: 20)
                            .modifier(ClipShapeModifier(shape: designConfig.image1.clipShape))
                            .onTapGesture {
                                selectedElement = .image(designConfig.image1)
                                showEditor = true
                            }
                        Spacer()
                    }
                    .padding()
                    Text("Duck Energy")
                        .bold()
                        .font(.title2)
                    
                        .onTapGesture {
                            selectedElement = .text(designConfig.text1)
                            showEditor = true
                        }
                    Text("Good Day Elements")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .onTapGesture {
                            selectedElement = .text(designConfig.text2)
                            showEditor = true
                        }
                    
                    HStack{
                        Button {
                            selectedElement = .button(designConfig.button1)
                            showEditor = true

                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "play.fill")
                                    .padding(2)
                                    .padding(.trailing, 2)
                                Text("Play")
                                    .padding()
                                    .padding(.leading, 2)
                                    .bold()
                                Spacer()
                            }.foregroundStyle(.red)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.gray)
                                    .opacity(0.2)
                            }
                            .padding(.trailing, 1)
                            .padding(.leading, 5)
                            
                        }
                        
                        
                        Button {
                            selectedElement = .button(designConfig.button2)
                            showEditor = true
                        } label: {
                            HStack{
                                Spacer()
                                Image(systemName: "shuffle")
                                    .padding(2)
                                    .padding(.trailing, 2)
                                Text("Shuffle")
                                    .padding()
                                    .padding(.leading, 2)
                                    .bold()
                                Spacer()
                            }.foregroundStyle(.red)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.gray)
                                
                                    .opacity(0.2)
                            }
                            .padding(.trailing, 5)
                            .padding(.leading, 1)
                        }
                    }
                    .padding()
                    .shadow(radius: 20)
                    
                    Text("Duck elements for having your day full of good energy and wisdom ...")
                        .onTapGesture{
                            selectedElement = .text(designConfig.text3)
                            showEditor = true
                        }
                    Divider()
                    List{
                        ForEach(listElements){element in
                            HStack{
                                Image(element.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .onTapGesture {
                                        selectedElement = .image(designConfig.list1.imageConfig)
                                        showEditor = true
                                    }
                                Text(element.quote)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        selectedElement = .text(designConfig.list1.textConfig)
                                        showEditor = true
                                    }
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .padding(.trailing)
                                // add logic of modifying the icon
                            }
                            
                        }
                    }.listStyle(.plain)
                }
            }
            .padding()
            .scaleEffect(showEditor == true ? 0.55 : 1.0)
            .animation(.spring(), value: showEditor)
            .offset(y: showEditor == true ? -geo.size.height * 0.25 : 0)
            .sheet(isPresented: $showEditor) {
                Group{
                    if let selected = selectedElement {
                        switch selected {
                        case .image(let config):
                            ImageEditorView(config: config)

                        case .text(let config):
                            TextEditorView(config: config)

                        case .button(let config):
                            ButtonEditorView(config: config)

                        case .list(let config):
                            ListEditorView(config: config)
                        }
                    }
                }.presentationDetents([.fraction(0.45)])
                    .presentationBackground(.ultraThickMaterial)
            }
        }

    }
}

#Preview {
    DesignTemplate()
}
