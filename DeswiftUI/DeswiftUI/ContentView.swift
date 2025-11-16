//
//  ContentView.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 12/11/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var thumbnailRefreshID = UUID()
    @StateObject private var persistentConfig = DesignTemplateConfig()
    @State private var templateName: String = "Music album"
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    Text("Design Studio")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                        .opacity(0.8)
                        .bold()
                    Spacer()
                }.padding([.bottom, .leading])
                HStack {
                    Text("Templates")
                        .font(.title)
                        .bold()
                    Spacer()
                }.padding(.leading)
                Spacer()
                NavigationLink(destination: DesignEditor(designConfig: persistentConfig)){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.gray)
                            .opacity(0.2)
                                
                        DesignEditor(designConfig: persistentConfig)
                            .scaleEffect(0.8)
                            .clipped()
                            .allowsHitTesting(false)
                            .id(thumbnailRefreshID)
                    }.padding(.horizontal, 20)
                    .onAppear {
                            self.thumbnailRefreshID = UUID()
                        }
                }
                Spacer()
                HStack{
                    if isEditing {
                        TextField("Enter new name", text: $templateName)
                            .font(.body)
                            .padding(.leading, 30)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                            .onSubmit {
                                isEditing = false
                            }
                    } else {
                        Text(templateName)
                            .bold()
                            .padding(.leading, 30)
                    }
                    Spacer()
                    
                    
                    Button{
                        isEditing.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .padding(.trailing, 30)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
