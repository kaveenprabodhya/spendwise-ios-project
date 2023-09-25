//
//  SelectOptionView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-24.
//

import SwiftUI

struct SelectOptionView: View {
    var label: String
    @Binding var isOptionPresented: Bool
    @Binding var selectedOption: String
    let placeholderString:String
    let options: [String]
    var body: some View {
            VStack {
                Text("\(label)")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 2)
                    .frame(height: 50)
                    .overlay {
                        Button {
                            withAnimation {
                                self.isOptionPresented.toggle()
                            }
                        } label: {
                            HStack {
                                Text(selectedOption.isEmpty ? placeholderString : selectedOption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: self.isOptionPresented ? "chvron.up" : "chevron.down")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                            }.padding(.horizontal, 10)
                        }
                    }
            }.padding()
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
        @State var selected: String = ""
        @State var isPresented: Bool = false
        SelectOptionView(label: "Pick your Budget Type", isOptionPresented: $isPresented, selectedOption: $selected, placeholderString: "Select Type", options : ["Option1", "Option2", "Option3"])
    }
}
