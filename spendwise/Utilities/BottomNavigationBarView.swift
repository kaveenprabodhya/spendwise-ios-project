//
//  BottomNavigationBarView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-06.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @State private var expand = false
    @Binding var index: Int
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .bottom) {
                if expand {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            expand = false
                        }
                }
                ZStack(alignment: .top) {
                    Circle()
                        .trim(from: 0.5, to: 1)
                        .fill(.clear)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    ZStack {
                        NavigationLink {
                            NewTransactionView().onAppear{
                                expand = false
                            }
                        } label: {
                            VStack(spacing: 10){
                                Circle()
                                    .fill(Color("ColorAzureBlue"))
                                    .frame(width: 85, height: 85)
                                    .overlay {
                                        VStack {
                                            Image(systemName: "arrow.left.arrow.right.square")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                                .scaledToFit()
                                            Text("Txn")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                            }
                        }
                        .offset(x:-90, y: 95)
                        NavigationLink {
                            NewBudgetView().onAppear{
                                expand = false
                            }
                        } label: {
                            VStack(spacing: 10){
                                Circle()
                                    .fill(Color("ColorLavenderPurple"))
                                    .frame(width: 85, height: 85)
                                    .overlay {
                                        VStack {
                                            Image(systemName: "chart.pie.fill")
                                                .resizable()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                                .scaledToFit()
                                            Text("Budget")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                            }
                        }
                        .offset(x: 60, y: 35)
                    }
                }
                .offset(y: UIScreen.main.bounds.width / 2.8)
                .opacity(self.expand ? 1 : 0)
            }
//            .edgesIgnoringSafeArea(.bottom)
            .frame(maxHeight: .infinity, alignment: .bottom)
            TabBar(index: $index, expand: $expand)
            .background(Color("ColorVividBlue"))       
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
//        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBarView(index: .constant(1))
            .padding(.bottom, 12)
            .edgesIgnoringSafeArea(.all)
    }
}
