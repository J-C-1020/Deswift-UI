//
//  DesignEditor.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 16/11/25.
//

import SwiftUI

struct DeviceFrame<Content: View>: View {
    let content: Content
    
    let aspectRatio: CGFloat = 9 / 19.5
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("9:41")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)

                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "wifi")
                    Image(systemName: "battery.100")
                }
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            .padding(.top, 8)
            content
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(40)
        .shadow(radius: 10)
    }
}

struct DesignEditor: View {
    @ObservedObject var designConfig = DesignTemplateConfig()
    @State private var showEditor: Bool = false
    @State private var selectedElement: EditableElement? = nil
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                DeviceFrame{
                    DesignTemplate(designConfig: designConfig, selectedElement: $selectedElement, showEditor: $showEditor)
                        .padding(.horizontal, 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scaleEffect(showEditor == true ? 0.50 : 1.0)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    InstructionsView()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    DesignEditor()
}
