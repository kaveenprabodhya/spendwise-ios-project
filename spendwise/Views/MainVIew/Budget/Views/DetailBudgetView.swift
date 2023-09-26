//
//  DetailBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct DetailBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isSheetRemovePresented: Bool = false
    @State private var capsuleWidth: CGFloat = 0
    
    func getTextWidth(text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font]
        let textSize = (text as NSString).size(withAttributes: attributes)
        return ceil(textSize.width)
    }
    
    var body: some View {
        NavigationStack {
        ZStack{
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")], headerContent: {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text("Monthly Budget")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        VStack {
                            Text("You’ve spent")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            Capsule()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: capsuleWidth, height: 30)
                                .overlay{
                                    Text("LKR \(formatCurrency(value: 100000100))")
                                        .foregroundColor(Color("ColorVividBlue"))
                                        .font(.system(size: 18, weight: .bold))
                                        .onAppear{
                                            let textWidth = getTextWidth(text: "LKR \(formatCurrency(value: 10000100))")
                                            capsuleWidth = textWidth + 30
                                        }
                                }
                            Text("for the past \(10) days")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 8)
                        Spacer()
                    }
                }
                .padding()
            }) {
                VStack {
                    HStack {
                        Text("Edit your Budget")
                            .font(.system(size: 18, weight: .medium))
                        Spacer()
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(Color("ColorSilverGray"))
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "pencil.circle")
                                        .foregroundColor(.white)
                                        .frame(width: 35, height: 35)
                                }
                        }

                    }
                    .padding(30)
                    HStack {
                        Text("What’s left to spend")
                        Spacer()
                        Text("\(formatCurrency(value: 170001))")
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }

            if isSheetRemovePresented {
                ZStack(alignment: .bottom) {
                    Color.black.opacity(0.3)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.25)) {
                                self.isSheetRemovePresented = false
                            }
                        }
                    UnevenRoundedRectangleViewShape(topLeftRadius: 25, topRightRadius: 25, bottomLeftRadius: 0, bottomRightRadius: 0)
                        .fill(.white)
                        .overlay {
                            VStack(spacing: 0) {
                                Capsule()
                                    .fill(Color.secondary)
                                    .frame(width: 40, height: 3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 20)
                                    .onTapGesture {
                                        withAnimation {
                                            self.isSheetRemovePresented = false
                                        }
                                    }
                                Text("Remove")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.top, 10)
                                    .padding(.bottom, 20)
                                Text("Are you sure do you wanna remove this budget?")
                                    .font(.system(size: 18, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 250)
                                    .padding(.bottom, 30)
                                HStack {
                                    Button {
                                        
                                    } label: {
                                    }
                                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 164, height: 56, label: "Yes", cornerRadius: 16))
                                    
                                    Button {
                                        withAnimation(.linear(duration: 0.25)) {
                                            self.isSheetRemovePresented = false
                                        }
                                    } label: {
                                    }
                                    .buttonStyle(CustomButtonStyle(fillColor: "ColorSilverGray", width: 164, height: 56, label: "No", cornerRadius: 16))
                                    
                                }
                                Spacer()
                            }
                        }
                        .frame(height: 261)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.height > 50 {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            isSheetRemovePresented = false
                                        }
                                    }
                                }
                        )
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Detail Budget")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation(.linear(duration: 0.25)) {
                        self.isSheetRemovePresented = true
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
            }
        }
    }
    }
}

struct DetailBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBudgetView()
    }
}
