//
//  NewBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedBudgetTypeOption = ""
    @State private var selectedBudgetCategoryOption = ""
    @State private var inputValue = ""
    @State private var showGreeting = false
    @State var isOptionModalPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 240, sheetHeight: 752, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]){
                    VStack(spacing: 0) {
                        Text("Create Your Budget")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 15)
                            .padding(.all, 20)
                        InputTextFieldView(label: "Name of Budget", textInput: $inputValue)
                    
                        VStack {
                            Text("Cycle of budget")
                                .font(.system(size: 14, weight:  .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("Pick your dates")
                                        .font(.system(size: 18, weight:  .medium))
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color("ColorVividBlue"))
                                        .font(.system(size: 28, weight:  .medium))
                                }
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 2)
                            }
                        }.padding()
                       
                        VStack(spacing: 0) {
                            Text("Receive Alert")
                                .font(.system(size: 18, weight:  .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Receive alert when it reaches some point.")
                                Spacer()
                                CustomToggleView(isOn: $showGreeting)
                            }
                        }.padding()
                        Spacer()
                        NavigationLink {
                            SecondView()
                        } label: {
                            
                        }.buttonStyle(CustomNavigationLinkButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Continue"))
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("New Budget")
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
            }
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 480, sheetHeight: 456, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]){
                    VStack(spacing: 0) {
                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("New Budget")
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
            }
        }
    }
}

struct CustomNavigationLinkButtonStyle: ButtonStyle {
    var fillColor: String
    var width: CGFloat
    var height: CGFloat
    var label: String
    func makeBody(configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color(fillColor))
            .frame(width: width, height: height)
            .overlay {
                Text(label)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
    }
}

struct CustomToggleView: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 55, height: 30)
                .foregroundColor(isOn ? Color("ColorVividBlue") : .gray)
                .overlay(
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .shadow(radius: isOn ? 1 : 0, y: isOn ? 2 : 0)
                        .offset(x: isOn ? 10 : -10, y: 0)
                )
        }
    }
}

struct NewBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NewBudgetView()
    }
}
