//
//  CustomToolBar.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 12/4/24.
//


import SwiftUI

struct CustomToolBar: ViewModifier {
    
    @Binding var charStatus: CharacterStatus
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        ForEach(CharacterStatus.allCases) { status in
                            Button(status.rawValue) {
                                charStatus = status
                            }
                        }
                    } label: {
                        // Image(systemName: "line.3.horizontal.decrease.circle")
                        Label("Status", systemImage:"line.3.horizontal.decrease.circle" )
                    }
                    
                }
            }
    }
}

extension View {
    func customToolBar(charStatus: Binding<CharacterStatus>) -> some View {
        modifier(CustomToolBar(charStatus: charStatus))
    }
}
