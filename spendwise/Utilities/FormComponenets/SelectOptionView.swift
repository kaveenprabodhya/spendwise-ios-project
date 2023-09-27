//
//  SelectOptionView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-24.
//

import SwiftUI

struct SelectOptionView<T: Hashable>: View {
    var label: String
    @State private var isOptionPresented:Bool = false
    @Binding var selectedOption: String
    var sheetLabel: String
    let placeholderString:String
    let options: [T]
    var fontColor: Color?
    var iconColor: Color?
    var placeholderStringColor: Color?
    var placeholderStringFontSize: CGFloat?
    var fontSize: CGFloat?
    var strokeColor: Color?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            VStack(spacing: 0) {
                if !label.isEmpty {
                    Text("\(label)")
                        .foregroundColor(fontColor != nil ? fontColor! : .black)
                        .font(.system(size: fontSize != nil ? fontSize! : 18, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                RoundedRectangle(cornerRadius: 15)
                    .stroke(strokeColor != nil ? strokeColor! : .black, lineWidth: 2)
                    .frame(height: 65)
                    .overlay {
                        Button {
                            withAnimation {
                                self.isOptionPresented.toggle()
                            }
                        } label: {
                            HStack {
                                Text(selectedOption.isEmpty ? placeholderString : selectedOption)
                                    .fontWeight(.medium)
                                    .font(.system(size: placeholderStringFontSize != nil ? placeholderStringFontSize! : 24, weight: .medium))
                                    .foregroundColor(placeholderStringColor != nil ? placeholderStringColor! : .black)
                                Spacer()
                                Image(systemName: self.isOptionPresented ? "chevron.up" : "chevron.down")
                                    .fontWeight(.medium)
                                    .foregroundColor(iconColor != nil ? iconColor! : .black)
                            }.padding(.horizontal, 10)
                        }
                    }
            }
            .sheet(isPresented: $isOptionPresented) {
                VStack {
                    Capsule()
                           .fill(Color.white)
                           .opacity(0.5)
                           .frame(width: 35, height: 5)
                           .padding(6)
                           .onTapGesture {
                               dismiss()
                           }
                    VStack {
                        Text(sheetLabel)
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Divider()
                            .frame(height: 2)
                            .background(.white)
                            .padding()
                        ScrollView(showsIndicators: false) {
                            ForEach(options, id: \.self) { option in
                                Button(action: {
                                    withAnimation {
                                        self.isOptionPresented = false
                                        if let budgetCategory = option as? BudgetCategory {
                                            self.selectedOption = budgetCategory.name
                                        }
                                        if let val = option as? String {
                                            self.selectedOption = val
                                        }
                                    }
                                }) {
                                    if let budgetCategory = option as? BudgetCategory {
                                        Text("\(budgetCategory.name)")
                                            .font(.system(size: 24))
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    if let val = option as? String {
                                        Text("\(val)")
                                            .font(.system(size: 24))
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding()
                }
                .background(LinearGradient(
                    gradient: Gradient(colors: [.blue, .green]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                ))
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
            }
    }
}

struct DropDownMenuList: View {
    var options: [String]
    let onSelectedaction: (_ option: String) -> Void
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(options, id: \.self) { option in
                    DropDownMenuListRow(option: option, onSelectedaction: self.onSelectedaction)
                }
            }
        }
        .frame(height: 200)
        .padding(.vertical, 5)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 2)
        }
    }
}

struct DropDownMenuListRow: View {
    var option: String
    let onSelectedaction: (_ option: String) -> Void
    var body: some View {
        Button {
            self.onSelectedaction(option)
        } label: {
            Text(option)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
                .padding(.vertical, 5)
                .padding(.horizontal)
        }

    }
}

struct SelectOptionView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var viewModel = BudgetViewModel()
        SelectOptionView(label: "Pick your Budget Type", selectedOption: .constant(""), sheetLabel: "Select Your Budget Type", placeholderString: "Select Type", options : ["xxxxxxx", "ffffff"])
    }
}
