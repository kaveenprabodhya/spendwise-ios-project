//
//  IncomeDetailView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct TransactionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 240, sheetHeight: 647, gradientColors: [Color("ColorForestGreen"), Color("ColorTeal")], headerContent: {
                    VStack(alignment: .center) {
                        VStack(spacing: 0) {
                            Text("LKR 20000")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.top, 20)
                                .padding(.bottom, 15)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                }){
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("ColorBurgundy"))
                                .frame(width: 400, height: 82)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Text("Type")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("Expense")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Category")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("Shopping")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Wallet")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("Apple")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                
                        }
                        .frame(height: 40)
                        .offset(y: -15)
                        .padding(.bottom, 10)
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [18, 5]))
                            .frame(height: 1)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                        VStack {
                            Text("1 - Jun - 2019 16:20")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.black)
                                .padding(.vertical, 10)
                            Text("Description")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            Text("Attachment")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray)
                                .frame(width: 368, height: 248)
                                .overlay {
                                    Image("successful-alert")
                                        .resizable()
                                        .scaledToFit()
                                }
                            Spacer()
                            Button(action: {
                                
                            }, label: {})
                            .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Edit", cornerRadius: 16, iconName: "square.and.pencil"))
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Detail Transaction")
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

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView()
    }
}
