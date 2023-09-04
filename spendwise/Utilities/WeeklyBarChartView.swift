//
//  WeeklyBarChart.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct WeeklyBarChartView: View {
    let days: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    var body: some View {
        VStack(spacing: 12) {
            HStack{
                Text("This Week Overview")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 180)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorJadeGreen"))
                    .frame(width: 12, height: 12)
                Text("Income")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .fontWeight(.semibold)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorFireEngineRed"))
                    .frame(width: 12, height: 12)
                Text("Expense")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 10)
            VStack {
                HStack(spacing: 45){
                    ForEach(days, id: \.self) { day in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("ColorLightLavenderBlue"))
                                .frame(width: 8, height: 180)
                                .overlay {
                                    VStack {
                                        Spacer()
                                        VStack(spacing: 5) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("ColorFireEngineRed"))
                                            .frame(width: 8, height: 42)
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("ColorJadeGreen"))
                                                .frame(width: 8, height: 42)
                                        }
                                        
                                    }
                            }
                            Text(day)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("ColorSilverGray"), lineWidth: 3)
                    .frame(width: 385, height: 230)
            )
    //        .shadow(color: .secondary, radius: 1, x: 0, y: 1)
            
        }
        .padding()
        
    }
}

struct WeeklyBarChart_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyBarChartView()
            .preferredColorScheme(.light)
    }
}
