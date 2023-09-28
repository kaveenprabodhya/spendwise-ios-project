//
//  OverallBudgetCategoryCardView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-21.
//

import SwiftUI

struct OverallBudgetCategoryCardView: View {
    var primaryBackgroundColor: String
    var budgetCategoryName: String
    var amountAllocated: Double
    var amountSpent: Double
    var numberOfDaysSpent: Int
    var footerMessage: FooterMessage
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(primaryBackgroundColor))
            .frame(width: 400, height: 191)
            .overlay {
                VStack {
                    HStack(alignment: .center) {
                        HStack{
                            Circle()
                                .fill(Color(primaryBackgroundColor))
                                .frame(width: 14, height: 14)
                            Text(budgetCategoryName)
                                .font(.system(size: 16, weight: .semibold))
                        }.padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("ColorSnowWhite"))
                                
                            )
                        Spacer()
                        NavigationLink {
                            DetailBudgetView()
                        } label: {
                            Image(systemName: "arrow.forward.circle")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(Color("ColorWhite"))
                        }
                    }
                    VStack {
                        Text("Remaining LKR \(formatCurrency(value: calculateRemainingAmount(amountAllocated: amountAllocated, spent: amountSpent)))")
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        VStack {
                            GeometryReader { geometry in
                                ProgressView(value: calculateProgressBarValue(amountAllocated: amountAllocated, spent: amountSpent), total: 100)
                                    .progressViewStyle(RoundedRectProgressViewStyle(color: Color("ColorDarkBlue"), width: geometry.size.width))
                                    .accentColor(Color("ColorFreshMintGreen"))
                            }.padding(.bottom, 10)
                            HStack {
                                HStack(alignment: .bottom, spacing: 0) {
                                    Text("\(formatCurrency(value: amountSpent)) of ")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                    Text("\(formatCurrency(value: amountAllocated))")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Text("\(numberOfDaysSpent) days")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 5)
                        HStack {
                            if(footerMessage.warning){
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                Text(footerMessage.message)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(nil)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }else {
                                Text(footerMessage.message)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(nil)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    Spacer()
                }.padding()
            }
    }
    private func calculateProgressBarValue(amountAllocated: Double, spent: Double) -> Double {
        guard amountAllocated > 0 else {
            return 0.0
        }
        let progress = (spent / amountAllocated) * 100.0
        return min(max(progress, 0.0), 100.0)
    }
    private func calculateRemainingAmount(amountAllocated: Double, spent: Double) -> Double {
        let remainingAmount = amountAllocated - spent
        return max(remainingAmount, 0.0)
    }
}

struct OverallBudgetCategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        OverallBudgetCategoryCardView(primaryBackgroundColor: "ColorSecondTealGreen", budgetCategoryName: "Vacation", amountAllocated: 10000000, amountSpent: 3526001, numberOfDaysSpent: 12, footerMessage: FooterMessage(message: "Hello, .... ^_-", warning: false))
    }
}
