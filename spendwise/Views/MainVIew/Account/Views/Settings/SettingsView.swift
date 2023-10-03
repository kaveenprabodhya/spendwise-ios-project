//
//  SettingsView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var toCurrency: Bool = false
    @State var toLanguage: Bool = false
    @State var toTheme: Bool = false
    @State var toSecurity: Bool = false
    @State var toAbout: Bool = false
    @State var toHelp: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Button(action: {
                    toCurrency = true
                }, label: {
                    SettingListItem(labelName: "Currency", defaultValue: "LKR")
                })
                .navigationDestination(isPresented: $toCurrency) {
                    CurrencyView()
                }
                Button(action: {
                    toLanguage = true
                }, label: {
                    SettingListItem(labelName: "Language", defaultValue: "English")
                })
                .navigationDestination(isPresented: $toLanguage) {
                    LanguageView()
                }
                Button(action: {
                    toTheme = true
                }, label: {
                    SettingListItem(labelName: "Theme", defaultValue: "light")
                })
                .navigationDestination(isPresented: $toTheme) {
                    ThemeView()
                }
                Button(action: {
                    toSecurity = true
                }, label: {
                    SettingListItem(labelName: "Security", defaultValue: "Password")
                })
                .navigationDestination(isPresented: $toSecurity) {
                    SecurityView()
                }
                Spacer()
                Button(action: {
                    toAbout = true
                }, label: {
                    SettingListItem(labelName: "About")
                })
                Button(action: {
                    toHelp = true
                }, label: {
                    SettingListItem(labelName: "Help")
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Settings")
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
            }
        }
    }
}

struct SettingListItem: View {
    var labelName: String
    var defaultValue: String?
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(height: 73)
            .overlay {
                HStack(alignment: .center) {
                    Text("\(labelName)")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                    Spacer()
                    if let defVal = defaultValue {
                        Text("\(defVal)")
                            .foregroundStyle(Color(.systemGray))
                            .font(.system(size: 18, weight: .medium))
                    }
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color("ColorVividBlue"))
                }
                .padding(.horizontal, 18)
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
