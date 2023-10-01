//
//  FinancialReportView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct FinancialReportView: View {
    @Environment(\.dismiss) private var dismiss
    @State var sortedBy: String = ""
    @State var isOnSortClicked: Bool = false
    
    var body: some View {
        VStack{
            HStack {
                SelectOptionView(label: "", selectedOption: $sortedBy, sheetLabel: "Select an Option", placeholderString: "Monthly", options: ["Monthly", "Weekly", "Yearly"], iconColor: .black, placeholderStringColor: .black, placeholderStringFontSize: 18, height: 44 , cornerRadius: 40, strokeColor: .black){}
                    .frame(width: 116)
                Spacer()
                HStack(spacing: 0) {
                    UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                        .fill(Color("ColorVividBlue"))
                        .frame(width: 48, height: 48)
                        .overlay {
                            UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                                .stroke(.gray, lineWidth: 2)
                                .frame(width: 48, height: 48)
                        }
                        .overlay {
                            Image(systemName: "chart.xyaxis.line")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(.white)
                        }
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 16, topTrailingRadius: 16)
                        .fill(.white)
                        .frame(width: 48, height: 48)
                        .overlay {
                            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 16, topTrailingRadius: 16)
                                .stroke(.gray, lineWidth: 2)
                                .frame(width: 48, height: 48)
                        }
                        .overlay {
                            Image(systemName: "chart.pie.fill")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundStyle(Color("ColorVividBlue"))
                        }
                }
            }
            .padding(.horizontal, 16)
            VStack(alignment: .leading) {
                Text("Total Amount")
                    .font(.system(size: 24, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 18)
            VStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.gray.opacity(0.5))
                    .frame(width: 392, height: 64)
                    .overlay {
                        HStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color("ColorVividBlue"))
                                .frame(width: 182, height: 56)
                                .padding(5)
                                .overlay {
                                    Text("Expense")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundStyle(.white)
                                }
                            RoundedRectangle(cornerRadius: 32)
                                .fill(.gray.opacity(0.1))
                                .frame(width: 182, height: 56)
                                .padding(5)
                                .overlay {
                                    Text("Income")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundStyle(.white)
                                }
                        }
                    }
            }
            HStack {
                SelectOptionView(label: "", selectedOption: $sortedBy, sheetLabel: "Select an Option", placeholderString: "Transaction", options: ["Transaction", "Category"], iconColor: .black, placeholderStringColor: .black, placeholderStringFontSize: 16, height: 44, cornerRadius: 40, strokeColor: .gray.opacity(0.5)){}
                    .frame(width: 136)
                Spacer()
                Button(action: {
                    isOnSortClicked = true
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.5), lineWidth: 2)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image("sort-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                })
            }
            .padding(.horizontal, 15)
            VStack {
                TabView {
                    Text("First Tab Content")
                        .tabItem {
                            Image(systemName: "1.circle")
                            Text("Tab 1")
                        }
                        .tag(0)
                    VStack {
                        Text("Second Tab Content")
                        Image(systemName: "2.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Tab 2")
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Financial Report")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color.black)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
