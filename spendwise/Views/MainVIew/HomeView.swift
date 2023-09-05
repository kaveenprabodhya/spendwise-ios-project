//
//  HomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct HomeView: View {
    
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
                                .padding(.top, 35)
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
                ScrollView {
                    VStack{
                        WeeklyBarChartView()
                        VStack {
                            Text("My Budgets")
                                .font(.system(size: 20))
                        }
                    }
                }
                .overlay{
                    BottomNavigationBarView()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
