//
//  GlobaEditorView.swift
//  DeswiftUI
//
//  Created by Yolanda Cantu on 15/11/25.
//

import SwiftUI

struct GlobalEditorView: View {
    let selected: EditableElement
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundStyle(.secondary)
                .padding(.top, 8)

            ScrollView {
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
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

/*#Preview {
    GlobalEditorView()
}*/
