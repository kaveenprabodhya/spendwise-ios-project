//
//  BottomNavigationBarView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-06.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @State var expand: Bool
    @State var index: Int
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Circle()
                        .trim(from: 0.5, to: 1)
                        .fill(Color.white.opacity(0.1))
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
                .offset(y: UIScreen.main.bounds.width / 3)
                .opacity(self.expand ? 1 : 0)
            }.clipped()
            TabBar(index: self.$index, expand: self.$expand)
                .background(Color("ColorElectricIndigo"))
        }
        
    }
}

struct BottomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBarView(expand: false, index: 0)
    }
}
