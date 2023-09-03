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
        VStack {
            HStack{
                Text("This Week Overview")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorJadeGreen"))
                    .frame(width: 8, height: 42)
                Text("Income")
                    .font(.title3)
                    .fontWeight(.semibold)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorFireEngineRed"))
                    .frame(width: 8, height: 42)
                Text("Expense")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            VStack {
                HStack(spacing: 50){
                    ForEach(days, id: \.self) { day in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("ColorLightLavenderBlue"))
                                .frame(width: 8, height: 180)
                                .overlay {
                                    VStack {
                                        Spacer()
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("ColorFireEngineRed"))
                                            .frame(width: 8, height: 42)
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("ColorJadeGreen"))
                                            .frame(width: 8, height: 42)
                                    }
                            }
                            Text(day)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("ColorSilverGray"), lineWidth: 3)
                    .frame(width: 410, height: 230)
            )
    //        .shadow(color: .secondary, radius: 1, x: 0, y: 1)
            
        }
        
    }
}

struct WeeklyBarChart_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyBarChartView()
    }
}
