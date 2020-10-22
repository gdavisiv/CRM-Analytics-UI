//  13:44:00
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
    @State var dailySales = [
        //Last 7 Days of Data stored here
        DailySales(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 200, show: true),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 723, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 346, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 525, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 124, show: false),
        DailySales(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 220, show: false),
        DailySales(day: Date(), value: 669, show: false)
    ]
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
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
            
            VStack(spacing: 20){
                HStack(spacing: 15){
                    SalesView(sale: salesData[0])
                    
                    SalesView(sale: salesData[1])
                }
                
                HStack(spacing: 15){
                    SalesView(sale: salesData[2])
                    
                    SalesView(sale: salesData[3])
                    
                    SalesView(sale: salesData[4])
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            ZStack {
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], size: 45))
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Text("Units Sold in past 7 Days")
                            .font(.title2)
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top,20)
                    
                    HStack(spacing: 10){
                        ForEach(dailySales.indices,id: \.self){i in
                            //Toggle Button
                            GraphView(data: dailySales[i], allData: dailySales)
                            
                            //Spacing for Graphs
                            if dailySales[i].value != dailySales.last!.value{
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom,edges!.bottom == 0 ? 15 : 0)
                }
            }
            .padding(.top)
            .padding(.horizontal)
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
                    .fill(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.1))
                    .frame(height: 45)
                    
                if selected == title{
                    Capsule()
                        .fill(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
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

//Sample Model Data

struct Sales : Identifiable {
    var id = UUID().uuidString
    var title : String
    var value : String
    var color : Color
}

var salesData = [
    Sales(title: "Sold", value: "18,802", color: Color.green),
    Sales(title: "Returned", value: "1,302", color: Color.red),
    Sales(title: "Delivered", value: "18,802", color: Color.blue),
    Sales(title: "In Transit", value: "2,230", color: Color.purple),
    Sales(title: "Cancelled", value: "1,262", color: Color.orange)
]

//Model Data for units sold/etc

struct DailySales : Identifiable {
    var id = UUID().uuidString
    var day : Date
    var value : CGFloat
    var show : Bool
}

struct SalesView : View {
    var sale : Sales
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    Text(sale.title)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    
                    Text(sale.value)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(sale.color)
        .cornerRadius(10)
    }
}

struct CustomCorners : Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    func path(in rect: CGRect) -> Path {
         
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct GraphView : View {
    
    var data : DailySales
    var allData : [DailySales]
    
    var body: some View {
        VStack {
            GeometryReader{reader in
                VStack(spacing: 0){
                    
                    Spacer(minLength: 0)
                    
                        Text("\(Int(data.value))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(height: 20)

                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red.opacity(data.show ? 1 : 0.4))
                            .frame(height: calculateHeight(value: data.value, height: reader.frame(in: .global).height - 20))
                }
            }
                Text(customDataStyle(date: data.day))
                    .font(.caption2)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
        }
    }
    func customDataStyle(date: Date)->String{
        let format = DateFormatter()
        format.dateFormat = "MMM dd"
        return format.string(from: date)
    }
    
    func calculateHeight(value: CGFloat, height: CGFloat)->CGFloat{
        let max = allData.max {(max, sale) -> Bool in
            if max.value > sale.value{return false}
            else{return true}
        }
        let percent = value / max!.value
        
        return percent * height
    }
}
