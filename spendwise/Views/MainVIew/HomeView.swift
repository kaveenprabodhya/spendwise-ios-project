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
            VStack(spacing: 0) {
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
                                    VStack {
                                        Text(Date.now, format: .dateTime.day().month().year())
                                            .font(.system(size: 22))
                                            .foregroundColor(.white)
                                            .fontWeight(.medium)
                                    }
                                    .background(Color.clear)
                                    .offset(y: -6)
                                }
                                VStack {
                                    Ellipse()
                                        .fill(Color("ColorSnowWhite"))
                                        .frame(width: 72, height: 72)
                                        .overlay{
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 45, height: 45, alignment: .center)
                                                .foregroundColor(Color("ColorSilverGray"))
                                        }
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
                .padding(.bottom, 16)
                VStack {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(1..<3) { index in
                                            VStack {
                                                WeeklyBarChartView()
                                                Spacer()
                                            }.padding(.top, 10)
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                    Spacer()
                }.overlay {
                    BottomNavigationBarView(expand: self.expand, index: self.index)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
