//
//  SuperheroSearcher.swift
//  CursoiOS
//
//  Created by Juan Carlos Robledo Morales on 17/07/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct SuperheroSearcher: View {
    @State var superheroName: String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading:Bool = false
    var body: some View {
        VStack{
            TextField("", text: $superheroName, prompt: Text("Superman...").font(.title2).bold().foregroundColor(.gray))
            .foregroundColor(.white)
            .font(.title2)
            .bold()
            .padding(16)
            .border(.purple, width: 2)
            .padding(8)
            .autocorrectionDisabled()
            .onSubmit {
                loading = true
                print(superheroName)
                Task{
                    do{
                        wrapper = try await ApiNetwork().getHeroesByQery(query: superheroName)
                       }catch{
                        print("Error")
                    }
                    loading = false
                }
                
            }
            
            if loading {
                ProgressView().tint(.white)
            }
            NavigationStack{
                List(wrapper?.results ?? []){superhero in
                    ZStack{
                        SuperheroItem(superhero: superhero)
                        NavigationLink(destination: {
                            SuperheroDetail(id: superhero.id)
                        }){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                    

                    }.listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.backgroundApp)
    }
}

struct SuperheroItem:View {
    let superhero:ApiNetwork.Superhero
    var body: some View {
        ZStack{
//            superhero.image.url
            Rectangle()
            
            WebImage(url: URL(string: superhero.image.url))
                .resizable()	
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            
            VStack{
                Spacer()
                Text(superhero.name)
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.5))
            }
        }.frame(height: 200).cornerRadius(32)
        
    }
}

#Preview {
    SuperheroSearcher()
}
