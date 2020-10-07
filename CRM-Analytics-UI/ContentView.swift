//  05:20:00
//  ContentView.swift
//  CRM-Analytics-UI
//
//  Created by George Davis IV on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var tab = "USA"
    @Namespace var animation
    @State var subTab = "Today"
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    
                    Image(systemName: "line.horizontal.3")
                        .renderingMode(.template)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .shadow(radius: 1)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "bell")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    
                }

            }
            .padding()
            
            //Sub Menu
            HStack{
                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 0) {
                
                TabButton(selected: $tab, title: "USA", animation: animation)
                TabButton(selected: $tab, title: "Global", animation: animation)
                
            }
            .background(Color.white.opacity(0.8))
            .clipShape(Capsule())
            .padding(.horizontal)
            
            HStack(spacing: 20){
                ForEach(subTabs,id: \.self){tab in
                    Button(action: {subTab = tab}) {
                        Text(tab)
                            .fontWeight(.bold)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(subTab == tab ? 1 : 0.3))
                    }
                }
            }
            .padding()
            
            
            Spacer(minLength: 0)
        }
        .background(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
}
var subTabs = ["Today", "Week", "Month"]

struct TabButton : View {
    @Binding var selected : String
    var title : String
    var animation : Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                selected = title
            }
        }) {
            ZStack{
                //Capsule + Sliding Effect
                Capsule()
                    //Color.clear creats the right effect needed to give sliding Illusion
                    .fill(Color.clear)
                    .frame(height: 45)
                    
                if selected == title{
                    Capsule()
                        .fill(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .frame(height: 45)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
                Text(title)
                    .foregroundColor(selected == title ? .black : .white)
                    .fontWeight(.bold)
                //
            }
        }
    }
}
