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



var listElements: [element] = [
    element(image: "WaterDuck", quote: "Water bender"),
    element(image: "FireDuck", quote: "Fire bender"),
    element(image: "EarthDuck", quote: "Earth bender"),
    element(image: "AirDuck", quote: "Air bender")
]

struct DesignTemplate: View {
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Image("duck")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .shadow(radius: 20)
                    .clipShape(.containerRelative)
                Spacer()
            }
            .padding()
            Text("Duck Energy")
                .bold()
                .font(.title2)
            Text("Good Day Elements")
                .font(.title2)
                .foregroundStyle(.red)
            
            HStack{
                Button {
                    //
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
                    //
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
            Divider()
            List{
                ForEach(listElements){element in
                    HStack{
                        Image(element.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        Text(element.quote)
                            .padding(.horizontal, 5)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .padding(.trailing)
                        // add logic of modifying the icon
                    }
                    
                }
            }.listStyle(.plain)
        }

    }
}

#Preview {
    DesignTemplate()
}
