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
    @State var isPickDates: Bool = false
    @State private var showGreeting = false
    @State private var openFrequency = false
    @ObservedObject var viewModel = BudgetViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 240, sheetHeight: 752, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")], headerContent: {}){
                    VStack(spacing: 0) {
                        Text("Create Your Budget")
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 30)
                            .padding(.horizontal, 15)
                        
                        BottomLineTextFieldView(label: "Name of Budget", placeholder: "", textInputVal: $inputValue)
                            .padding(.vertical, 6)
                        
                        SelectOptionView(label: "Pick your Budget Type", selectedOption: $selectedBudgetTypeOption, sheetLabel: "Select Your Budget Type", placeholderString: "Select Type", options : ["Monthly", "Weekly", "Yearly"], placeholderStringFontSize: 20) {}
                            .padding(.vertical, 6)
                            .padding(.horizontal, 15)
                        VStack {
                            Text("Cycle of budget")
                                .font(.system(size: 18, weight:  .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                withAnimation {
                                    self.isPickDates.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Pick your dates")
                                        .font(.system(size: 20, weight:  .medium))
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color("ColorVividBlue"))
                                        .font(.system(size: 28, weight:  .medium))
                                }
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: 2)
                            }
                            .sheet(isPresented: $isPickDates) {
                                VStack(spacing: 0) {
                                    VStack(spacing: 0) {
                                        Button {
                                            self.isPickDates = false
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .fill(Color("ColorMistyLavender"))
                                                    .frame(width: 40, height: 40)
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color("ColorVividBlue"))
                                                    .font(.system(size: 24, weight:  .medium))
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 38)
                                    VStack(spacing: 0) {
                                        Text("Select Your budget cycle")
                                            .font(.system(size: 28, weight: .semibold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 5)
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text("Enable Frequency")
                                                .font(.system(size: 18, weight:  .medium))
                                            Spacer()
                                            CustomToggleView(isOn: $openFrequency)
                                        }
                                    }.padding()
                                    if openFrequency {
                                        VStack {
                                            SelectOptionView(label: "Frequency", selectedOption: $selectedBudgetTypeOption, sheetLabel: "Select Your Frequency", placeholderString: "Select Type", options : ["Monthly", "Weekly", "Yearly"]){}
                                        }
                                    }
                                    MultiDatePickerExample()
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        
                                    }
                                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Set Cycle", cornerRadius: 35))

                                }
                                .padding()
                            }
                        }.padding()
                        
                        SelectOptionView(label: "Pick your Budget Category", selectedOption: $selectedBudgetCategoryOption, sheetLabel: "Select Your Budget Category", placeholderString: "Select Category", options : viewModel.budgetCategoryArray, placeholderStringFontSize: 20) {}
                            .padding(.vertical, 6)
                            .padding(.horizontal, 15)
                            Spacer()
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
                        
                        NavigationLink(destination: SecondView(inputValueOfName: $inputValue, selectedBudgetTypeOption: $selectedBudgetTypeOption, selectedBudgetCategoryOption: $selectedBudgetCategoryOption), label: {
                            Text("")
                        }).buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Continue", cornerRadius: 16))
                        
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

struct MultiDatePickerExample: View {
    @Environment(\.calendar) var calendar
    @Environment(\.timeZone) var timeZone
    
    @State private var dates: Set<DateComponents> = []
    
    var body: some View {
        let currentDate = calendar.date(from: DateComponents(timeZone: timeZone))!
        let currentMonth = calendar.component(.month, from: currentDate)
        
        // Calculate the maximum selectable date range based on budget type
        let maxSelectableRange: Range<Date> = {
            if isMonthlyBudgetType() {
                // If budget type is monthly, allow any range within the current month
                let startOfMonth = calendar.date(from: DateComponents(timeZone: timeZone, year: calendar.component(.year, from: currentDate), month: currentMonth, day: 1))!
                let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
                return startOfMonth..<endOfMonth
            } else {
                // If budget type is weekly, limit the range to 1-7 days
                let maxEndDate = calendar.date(byAdding: DateComponents(day: 7), to: currentDate)!
                return currentDate..<maxEndDate
            }
        }()
        
        return MultiDatePicker("Dates Available", selection: $dates, in: maxSelectableRange)
            .fixedSize()
    }
    
    // Replace this with your actual logic for determining the budget type
    func isMonthlyBudgetType() -> Bool {
        // You should implement logic to determine if the budget type is monthly or weekly
        // For this example, we assume it's monthly
        return true
    }
}

struct SecondView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var inputValueOfName: String
    @Binding var selectedBudgetTypeOption: String
    @Binding var selectedBudgetCategoryOption: String
    @State var textInputAmountVal: String = ""
    @State var isSubmissionSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 480, sheetHeight: 456, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")], headerContent: {}){
                    VStack(spacing: 0) {
                        Spacer()
                        Text("Set Amount")
                            .font(.system(size: 22, weight: .medium))
                        VStack(spacing: 0) {
                            BottomLineTextFieldView(label: "", placeholder: "0.00", textInputVal: $textInputAmountVal)
                                .keyboardType(.decimalPad)
                                .frame(width: 150)
                        }.padding()
                        HStack (spacing: 10) {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("ColorMistyLavender"))
                                    .frame(height: 46)
                                    .overlay {
                                        Text("\(formatCurrency(value: 150000))")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ColorVividBlue"))
                                    }
                            }
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("ColorMistyLavender"))
                                    .frame(height: 46)
                                    .overlay {
                                        Text("\(formatCurrency(value: 1500))")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ColorVividBlue"))
                                    }
                            }
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("ColorMistyLavender"))
                                    .frame(height: 46)
                                    .overlay {
                                        Text("\(formatCurrency(value: 15000))")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ColorVividBlue"))
                                    }
                            }
                        }
                        .padding()
                        Spacer()
                        Button("", action: {
                            isSubmissionSuccess = true
                        })
                        .buttonStyle(
                            CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Create", cornerRadius: 16)
                        )
                        Spacer()
                    }.padding()
                }
            }
            .navigationDestination(isPresented: $isSubmissionSuccess) {
                ContentView(index: 3)
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

struct CustomButtonStyle: ButtonStyle {
    var fillColor: String
    var width: CGFloat
    var height: CGFloat
    var label: String
    var cornerRadius: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(fillColor))
            .frame(width: width, height: height)
            .overlay {
                Text(label)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
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
