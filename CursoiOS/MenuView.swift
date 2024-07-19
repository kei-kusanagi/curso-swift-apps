//
//  MenuView.swift
//  CursoiOS
//
//  Created by Juan Carlos Robledo Morales on 16/07/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink(destination:IMCView()){
                    Text("IMC Calculator")
                }
                NavigationLink(destination:SuperheroSearcher()){
                    Text("Superhero finder")
                }
                
                Text("App 3")
                Text("App 4")
            }
        }
    }
}

#Preview {
    MenuView()
}
