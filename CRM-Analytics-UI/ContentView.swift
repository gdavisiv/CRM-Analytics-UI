//
//  ContentView.swift
//  CRM-Analytics-UI
//
//  Created by George Davis IV on 9/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
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
            
            HStack{
                Text("Dashboard")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                
                Spacer(minLength: 0)
            }
            .padding()
            
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
}
