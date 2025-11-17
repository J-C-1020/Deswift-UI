//
//  InstructionsView.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 16/11/25.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("How it works?")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.red)
                    .opacity(0.8)
                
                Text("Tap any UI element inside the editor to change its properties.")
                    .font(.title2)
                    .bold()
                VStack(alignment: .leading){
                    Text("1) Play with your creativity")
                        .font(.title3)
                        .foregroundStyle(Color(.secondaryLabel))
                    Text("2) Modify the elements and create your unique design")
                        .font(.title3)
                        .foregroundStyle(Color(.secondaryLabel))
                    Text("3) Keep in mind the Human Interface Guidelines!")
                        .font(.title3)
                        .foregroundStyle(Color(.secondaryLabel))
                }
                
                Divider()
                    .foregroundStyle(.black)
                
                Text("Some tips")
                    .font(.title)
                    .foregroundStyle(.red)
                    .opacity(0.8)
                    .bold()
                
                VStack(alignment: .leading){
                
                    Text("• Keep elements well balanced and with a clear hierarchical order")
                        .padding(.bottom, 2)
                            
                    Text("• Keep elements well balanced and with a clear hierarchical order")
                        .padding(.bottom, 2)
                    
                    Text("• Elements with more prevalence should stick out more, either through shape, size, color, or position")
                        .padding(.bottom, 2)
                            
                    Text("• Be consistent. UI element styles and colors should be applied uniformly across the view")
                        .padding(.bottom, 2)
                            
                    Text("• Be consistent. UI element styles and colors should be applied uniformly across the view")
                        .padding(.bottom, 2)
                    
                }.font(.default)
                
                
                HStack{
                    Link("Learn More", destination: URL(string: "https://developer.apple.com/design/human-interface-guidelines")!)
                        .font(.callout)
                        .foregroundColor(.blue)
                        .underline()
                    Spacer()
                }
            } .padding(40)
        }
       
}

#Preview {
    InstructionsView()
}
