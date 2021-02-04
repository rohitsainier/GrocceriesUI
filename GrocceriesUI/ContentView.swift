//
//  ContentView.swift
//  GrocceriesUI
//
//  Created by Rohit Saini on 01/02/21.
//

import SwiftUI

struct ContentView: View {
    @State var selected = "Home"
    var body: some View {
        NavigationView{
            VStack{
                if selected == "Home"{
                    Home()
                }
                else if selected == "Wishlist"{
                    GeometryReader{_ in
                        Text("Wishlist")
                    }
                }
                else{
                    GeometryReader{_ in
                        Text("Cart")
                    }
                }
                CustomTabView(selected: $selected)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTabView:View{
    @Binding var selected: String
    var body: some View{
        HStack{
            ForEach(tabs,id:\.self){ i in
                VStack(){
                    Capsule().fill(Color.clear).frame(height:5)
                        .overlay(
                            Capsule().fill(self.selected == i ? Color("Color") : Color.clear).frame(width:55,height:5)
                        )
                    Button(action: {
                        self.selected = i
                    }, label: {
                        VStack{
                            Image(i).renderingMode(.original)
                            Text(i).foregroundColor(.black)
                        }
                    })
                }
            }
        }.padding(.horizontal)
    }
}

struct Home:View{
    @State var txt = ""
    var body: some View{
        VStack(spacing:15){
            HStack(spacing:12){
                Image("rp1").renderingMode(.original).resizable().frame(width:30,height: 30)
                Text("Hi, Sonu").font(.body)
                Spacer()
                Button(action: {}, label: {
                    Image("filter").renderingMode(.original)
                })
            }
            
            
            ScrollView(.vertical,showsIndicators:false){
                VStack(spacing:15){
                    HStack(spacing:15){
                        HStack{
                            Image(systemName: "magnifyingglass").font(.body)
                            TextField("Search Groceries", text: $txt)
                        }.padding()
                        .background(Color("Color1"))
                        .cornerRadius(20)
                        Button(action: {}, label: {
                            Image("mic").renderingMode(.original)
                        })
                    }
                    ZStack{
                        Image("top").renderingMode(.original).resizable().overlay(
                            VStack{
                                Spacer()
                                HStack{
                                    Text("Get 20% Off").font(.title).foregroundColor(.white)
                                    Spacer()
                                }
                                .padding()
                            }
                        )
                    }
                    HStack{
                        Text("Category").font(.body)
                        Spacer()
                        Button(action: {}, label: {
                            Text("More")
                        })
                        .foregroundColor(Color("Color"))
                    }
                    ScrollView(.horizontal,showsIndicators:false){
                        HStack(spacing:15){
                            ForEach(categories,id:\.self){ i in
                                VStack{
                                    Image(i).renderingMode(.original)
                                    Text(i)
                                }
                            }
                        }
                    }
                    HomeBottomView()
                }
            }
        }.padding(.horizontal)
    }
}


struct HomeBottomView:View{
    var body: some View{
        VStack(spacing:15){
            HStack{
                Text("Fresh New Item").font(.headline)
                Spacer()
                Button(action: {}, label: {
                    Text("More")
                })
                .foregroundColor(Color("Color"))
            }
            .padding(.vertical,15)
            
            ScrollView(.horizontal,showsIndicators:false){
                HStack(spacing:15){
                    ForEach(freshitems){ i in
                        FreshCellView(data: i)
                    }
                }
            }
            
            HStack{
                Text("Receipe").font(.headline)
                Spacer()
                Button(action: {}, label: {
                    Text("More")
                })
                .foregroundColor(Color("Color"))
            }
            .padding(.vertical,15)
            
            ScrollView(.horizontal,showsIndicators:false){
                HStack(spacing:15){
                    ForEach(recipeitems){ i in
                        ReceipeCellView(data: i)
                    }
                }
            }
        }
    }
}

struct FreshCellView:View{
    @State var show = false
    var data:fresh
    var body: some View{
        ZStack{
            NavigationLink(destination: Detail(show: $show), isActive: $show){
                Text("")
            }
            VStack(spacing:10){
                Image(data.image).renderingMode(.original)
                Text(data.name).fontWeight(.semibold)
                Text(data.price).foregroundColor(.green).fontWeight(.semibold)
            }
            .onTapGesture {
                show.toggle()
            }
        }
       
    }
}


struct ReceipeCellView:View{
    var data:recipe
    var body: some View{
        VStack(spacing:10){
            Image(data.image).renderingMode(.original)
            HStack{
                Image(data.authorpic)
                VStack(alignment:.leading,spacing:6){
                    Text(data.name).fontWeight(.semibold)
                    Text(data.author).foregroundColor(.green).fontWeight(.semibold)
                }
                
            }
            
          
        }
    }
}


struct Detail:View{
    @Binding var show: Bool
    @State var top = UIApplication.shared.windows.last?.safeAreaInsets.top
    @State var count = 0
    var body: some View{
        VStack{
            Image("header").resizable().frame(height:UIScreen.main.bounds.height / 2.5)
                .overlay(
                    VStack{
                        HStack{
                            Button {
                                show = false
                            } label: {
                                Image("back").renderingMode(.original)
                            }
                            Spacer()
                            Button {
                                
                            } label: {
                                Image("download").renderingMode(.original)
                            }
                            Button {
                                
                            } label: {
                                Image("Wishlist").renderingMode(.original)
                            }

                        }.padding()
                        Spacer()
                    }
                )
            ScrollView(.vertical,showsIndicators:false){
                VStack(alignment:.leading,spacing:15){
                    Text("Seedless Lemon").font(.title)
                    Text("30.00 / kg").foregroundColor(.green)
                    Divider().padding(.vertical,10)
                    HStack{
                        Image("rp1").renderingMode(.original)
                        Text("Dana Organic Farm")
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("chat").renderingMode(.original)
                        }
                    }
                    Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available")
                        .foregroundColor(.gray)
                    HStack{
                        Text("Review (50)")
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("More")
                                .foregroundColor(Color("Color"))
                        }

                    }
                    .padding(.vertical ,10)
                    
                    HStack{
                        Image("rp2").renderingMode(.original)
                        VStack(alignment:.leading,spacing:10){
                            HStack{
                                Text("4")
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                            }
                            Text("Rohit Saini")
                            Text("The Lemon is so fresh that this is going to be").lineLimit(1).foregroundColor(.gray)
                        }
                    }.padding()
                    .background(Color("Color1"))
                    .cornerRadius(12)
                    
                    HStack(spacing:20){
                        Spacer(minLength: 5)
                        Button {
                            count += 1
                        } label: {
                            Image(systemName:"plus.circle").font(.largeTitle)
                        }
                        .foregroundColor(.green)
                        
                        Text("\(count)")
                        Button {
                            if count != 0{
                            count -= 1
                            }
                        } label: {
                            Image(systemName:"minus.circle").font(.largeTitle)
                        }.foregroundColor(.green)
                        
                        Button {
                            
                        } label: {
                            Text("Add to Cart")
                                .padding()
                        }
                        .foregroundColor(.white)
                        .background(Color("Color"))
                        .cornerRadius(10)
                        

                    }
                }
            }.overlay(
                VStack{
                    HStack{
                        Spacer()
                        HStack{
                            Text("4")
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.top,-40)
                        .padding(.trailing)
                    }
                    Spacer()
                }
            )
            .padding()
            .background(RoundedCorner().fill(Color.white))
            .padding(.top,-top! - 25)
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct RoundedCorner:Shape{
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

// sample datas...

var tabs = ["Home","Wishlist","Cart"]

var categories = ["Fruits","Vegetables","Beverages","Fish","Breads"]

struct fresh : Identifiable {
    
    var id : Int
    var name : String
    var price : String
    var image : String
}

struct recipe : Identifiable {
    
    var id : Int
    var name : String
    var author : String
    var image : String
    var authorpic : String
}

var freshitems = [
    fresh(id: 0, name: "Frozen Fish", price: "20.00 / pcs",image: "f1"),
    fresh(id: 1, name: "Seedless Lemon", price: "30.00 / kg",image: "f2"),
    fresh(id: 2, name: "Coffee Bread", price: "15.00 / pack",image: "f3")
]

var recipeitems = [
    recipe(id: 0, name: "Basil Pasta", author: "Karlien Nijhuis",image: "r1",authorpic: "rp1"),
    recipe(id: 1, name: "Banana Rice", author: "Harmen Porter",image: "r2",authorpic: "rp2"),
    recipe(id: 2, name: "Ramen", author: "Marama Peter",image: "r3",authorpic: "rp3")
]
