//
//  HomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State var index = 0
    @State var expand = false
    
    // MARK: - Body
    var body: some View {
        VStack{
            VStack(spacing: 20) {
                VStack{
                    CurvedSideRectangleViewShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTurquoiseBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 430, height: 480)
                        .edgesIgnoringSafeArea(.top)
                        .overlay {
                            VStack{
                                VStack{
                                    CustomTopNavigationView()
                                }
                                .padding(.top, 26)
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("ColorWhite"), lineWidth: 3)
                                        .frame(width: 130, height: 41)
                                        .overlay {
                                            VStack {
                                                Text("Octomber")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.white)
                                                    .fontWeight(.medium)
                                            }.background(Color.clear)
                                        }
                                        .offset(y:-10)
                                }
                                VStack {
                                    Ellipse()
                                        .fill(Color("ColorSnowWhite"))
                                        .frame(width: 72, height: 72)
                                    VStack(spacing: 8) {
                                        Text("Your available balance is")
                                            .foregroundColor(.white)
                                        Text("20,983")
                                            .font(.system(size: 28))
                                            .foregroundColor(.white)
                                        Text("By this time last month, you spent slightly higher (22,719)")
                                            .frame(width: 250)
                                            .lineLimit(nil)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                VStack {
                                    Spacer()
                                    Spacer()
                                    HStack(spacing: 20) {
                                        RoundedRectangle(cornerRadius: 20.0)
                                            .fill(Color("ColorEmeraldGreen"))
                                            .frame(width: 164, height: 82, alignment: .bottomLeading)
                                            .overlay {
                                                HStack {
                                                    RoundedRectangle(cornerRadius: 20.0)
                                                        .fill(Color("ColorSnowWhite"))
                                                        .frame(width: 48, height: 49, alignment: .leading)
                                                        .overlay{
                                                            Image(systemName: "square.and.arrow.down.fill")
                                                                .font(.system(size: 26))
                                                                .foregroundColor(Color("ColorEmeraldGreen"))
                                                        }
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Text("Income")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 14))
                                                        Text("LKR 5000")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                    }
                                                }
                                                .padding(5)
                                            }
                                        RoundedRectangle(cornerRadius: 20.0)
                                            .fill(Color("ColorRustyRed"))
                                            .frame(width: 164, height: 82, alignment: .bottomLeading)
                                            .overlay {
                                                HStack {
                                                    RoundedRectangle(cornerRadius: 20.0)
                                                        .fill(Color("ColorSnowWhite"))
                                                        .frame(width: 48, height: 49, alignment: .leading)
                                                        .overlay{
                                                            Image(systemName: "square.and.arrow.up.fill")
                                                                .font(.system(size: 26))
                                                                .foregroundColor(Color("ColorRustyRed"))
                                                        }
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Text("Expense")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 14))
                                                        Text("LKR 5000")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                    }
                                                }
                                                .padding(5)
                                            }
                                    }
                                    Spacer()
                                }
                            }
                        }
                }
                .padding(.bottom, 10)
                VStack {
                    ScrollView {
                        VStack{
                            WeeklyBarChartView()
                            VStack {
                                Text("My Budgets")
                                    .font(.system(size: 20))
                            }
                        }
                    }
                }.overlay {
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .bottom) {
//                            GeometryReader { _ in
//                                VStack {
//                                    Text("")
//                                }
//                            }.background(Color.black.opacity(0.06))
                            ZStack(alignment: .top) {
                                Circle()
                                    .trim(from: 0.5, to: 1)
                                    .fill(Color.white.opacity(0.1))
//                                    .fill(Color.accentColor)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                                ZStack {
                                    Button {
                                        
                                    } label: {
                                        VStack(spacing: 10){
                                            Circle()
                                                .fill(Color("ColorEmeraldGreen"))
                                                .frame(width: 95, height: 95)
                                                .overlay {
                                                    VStack {
                                                        Image(systemName: "square.and.arrow.down.fill")
                                                            .resizable()
                                                            .foregroundColor(.white)
                                                            .frame(width: 30, height: 30)
                                                            .scaledToFit()
                                                        Text("Income").fontWeight(.bold).foregroundColor(.white)
                                                    }
                                                }
                                        }
                                    }
                                    .offset(x:-100, y: 95)
                                    Button {
                                        
                                    } label: {
                                        VStack(spacing: 10){
                                            Circle()
                                                .fill(Color("ColorAzureBlue"))
                                                .frame(width: 95, height: 95)
                                                .overlay {
                                                    VStack {
                                                        Image(systemName: "chart.pie.fill")
                                                            .resizable()
                                                            .foregroundColor(.white)
                                                            .frame(width: 30, height: 30)
                                                            .scaledToFit()
                                                        Text("Budget").fontWeight(.bold).foregroundColor(.white)
                                                    }
                                                }
                                        }
                                    }
                                    .offset(y: 15)
                                    Button {
                                        
                                    } label: {
                                        VStack(spacing: 10){
                                            Circle()
                                                .fill(Color("ColorRustyRed"))
                                                .frame(width: 95, height: 95)
                                                .overlay {
                                                    VStack {
                                                        Image(systemName: "square.and.arrow.up.fill")
                                                            .resizable()
                                                            .foregroundColor(.white)
                                                            .frame(width: 30, height: 30)
                                                            .scaledToFit()
                                                        Text("Expense").fontWeight(.bold).foregroundColor(.white)
                                                    }
                                                }
                                        }
                                    }
                                    .offset(x:100, y: 95)
                                }
                                
                            }
                            .offset(y: UIScreen.main.bounds.width / 4)
                            .opacity(self.expand ? 1 : 0)
                        }.clipped()
                        // .border(.red, width: 3)
                        TabBar(index: self.$index, expand: self.$expand)
                            .background(Color("ColorElectricIndigo"))
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar: View {
    @Binding var index: Int
    @Binding var expand: Bool
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                self.index = 0
            } label: {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(self.index == 0 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 1
            } label: {
                Image(systemName: "arrow.left.arrow.right.square")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(self.index == 1 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                withAnimation(Animation.linear(duration: 0.7)) {
                    self.expand.toggle()
                }
            } label: {
                Image(systemName: self.expand ? "xmark" : "plus")
                    .font(.system(size: 42, weight: .medium))
                    .foregroundColor(Color("ColorElectricIndigo"))
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .offset(y: -5)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 2
            } label: {
                Image(systemName: "chart.pie.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(self.index == 2 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                
                self.index = 3
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(self.index == 3 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
        .padding(.bottom, 12)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
