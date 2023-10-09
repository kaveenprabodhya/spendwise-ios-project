//
//  NewBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = BudgetViewModel()
    var budget: Budget?
    
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
                            .padding(.bottom, 20)
                            .padding(.horizontal, 15)
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(viewModel.errorInputName ? Color("ColorCherryRed") : .black, lineWidth: 2)
                            .frame(height: 64)
                            .overlay {
                                BottomLineTextFieldView(
                                    label: "",
                                    placeholder: "Name of Budget",
                                    bottomLineColor: viewModel.errorInputName ? Color("ColorCherryRed") : .black,
                                    bottomLinePadding: 54,
                                    placeholderColor: viewModel.errorInputName ? Color("ColorCherryRed") : .black,
                                    textFieldFontSize: 20,
                                    placeholderFontSize: 20,
                                    textFieldHeight: 34,
                                    alignCetner: false, textInputVal: $viewModel.inputNameValue
                                )
                                    .padding(.horizontal, 12)
                                    .padding(.top, 10)
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 15)
                        SelectOptionView(
                            label: "Pick your Budget Type",
                            selectedOption: $viewModel.selectedBudgetTypeOption,
                            sheetLabel: "Select Your Budget Type",
                            placeholderString: "Select Type", 
                            options : ["Monthly", "Weekly", "Yearly"], 
                            iconColor: viewModel.errorSelectedBudgetType ? Color("ColorCherryRed") : .black,
                            placeholderStringColor: viewModel.errorSelectedBudgetType ? Color("ColorCherryRed") : .black,
                            placeholderStringFontSize: 20,
                            sheetHeight: 291,
                            cornerRadius: 25,
                            strokeColor: viewModel.errorSelectedBudgetType ? Color("ColorCherryRed") : .black
                        ) {}
                            .onChange(of: viewModel.selectedBudgetTypeOption) { newSelectedOption in
                                viewModel.errorSelectedBudgetType = false
                                if !viewModel.datePicked.isEmpty {
                                    viewModel.datePicked = ""
                                    viewModel.errorDatePicked = true
                                }
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 15)
                        VStack {
                            Text("Cycle of budget")
                                .font(.system(size: 18, weight:  .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                withAnimation {
                                    if !viewModel.selectedBudgetTypeOption.isEmpty {
                                        viewModel.isPickDates.toggle()
                                    } else {
                                        viewModel.errorSelectedBudgetType = true
                                    }
                                }
                            } label: {
                                HStack {
                                    let datePicked = viewModel.datePicked.isEmpty ? "Pick your dates" : viewModel.datePicked
                                    Text("\(datePicked)")
                                        .foregroundStyle(viewModel.errorDatePicked ? Color("ColorCherryRed") : .black)
                                        .font(.system(size: 20, weight:  .medium))
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(viewModel.errorDatePicked ? Color("ColorCherryRed") : Color("ColorVividBlue"))
                                        .font(.system(size: 28, weight:  .medium))
                                }
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(viewModel.errorDatePicked ? Color("ColorCherryRed") : .black, lineWidth: 2)
                            }
                            .onChange(of: viewModel.datePicked) { newSelectedOption in
                                viewModel.errorDatePicked = false
                            }
                            .sheet(isPresented: $viewModel.isPickDates) {
                                VStack(spacing: 0) {
                                    VStack(spacing: 0) {
                                        Text("Select Your budget cycle")
                                            .font(.system(size: 28, weight: .semibold))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text("Enable Frequency")
                                                .font(.system(size: 18, weight:  .medium))
                                            Spacer()
                                            CustomToggleView(isOn: $viewModel.openFrequency)
                                        }
                                    }
                                    .padding()
                                    if viewModel.openFrequency {
                                        VStack {
                                            SelectOptionView(
                                                label: "Frequency",
                                                selectedOption: $viewModel.selectedFrequencyOption,
                                                sheetLabel: "Select Your Frequency",
                                                placeholderString: "Select Type",
                                                options : ["Monthly", "Weekly", "Yearly"], placeholderStringFontSize: 20, 
                                                fontSize: 18,
                                                height: 44,
                                                sheetHeight: 291,
                                                cornerRadius: 25
                                            ){}
                                        }
                                    }
                                    MultiDatePickerView(viewModel: viewModel)
                                        .padding(.vertical, 8)
                                    Spacer()
                                    Button {
                                        if viewModel.dateRange.isEmpty && 
                                            viewModel.selectedBudgetTypeOption.localizedCaseInsensitiveContains("weekly"){
                                            viewModel.datePicked = ""
                                            viewModel.errorDatePicked = true
                                            viewModel.isRangeNotSelected = true
                                        } else {
                                            viewModel.isPickDates = false
                                        }
                                    } label: {
                                    }
                                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 363, height: 48, label: "Set Cycle", cornerRadius: 35))

                                }
                                .presentationDragIndicator(.visible)
                                .padding()
                            }
                        }.padding()
                        
                        SelectOptionView(
                            label: "Pick your Budget Category",
                            selectedOption: $viewModel.selectedBudgetCategoryOption,
                            sheetLabel: "Select Your Budget Category",
                            placeholderString: "Select Category",
                            options : viewModel.budgetCategoryArray,
                            iconColor: viewModel.errorSelectedBudgetCategory ? Color("ColorCherryRed") : .black,
                            placeholderStringColor: viewModel.errorSelectedBudgetCategory ? Color("ColorCherryRed") : .black,
                            placeholderStringFontSize: 20,
                            strokeColor: viewModel.errorSelectedBudgetCategory ? Color("ColorCherryRed") : .black
                        ) {}
                            .onChange(of: viewModel.selectedBudgetCategoryOption) { newSelectedOption in
                                viewModel.errorSelectedBudgetCategory = false
                            }
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
                                CustomToggleView(isOn: $viewModel.showGreeting)
                            }
                        }.padding()
                        Spacer()
                        
                        Button {
                            if viewModel.onBeforeContinueValidation() {
                                viewModel.isOnContinue = true
                            }
                        } label: {
                        }
                        .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Continue", cornerRadius: 16))
                        .navigationDestination(isPresented: $viewModel.isOnContinue) {
                            SecondView(viewModel: viewModel)
                        }
                        Spacer()
                    }
                }
            }
            .onAppear(perform: {
                if let budget = budget {
                    viewModel.inputNameValue = budget.name
                    viewModel.selectedBudgetTypeOption = viewModel.getBudgetType(type: budget.budgetType.type)
                    if let dateVal = budget.budgetType.date.stringValue() {
                        viewModel.datePicked = dateVal
                    }
                    viewModel.selectedBudgetCategoryOption = budget.category.name
                    viewModel.textInputAmountVal = String(budget.allocatedAmount)
                }
            })
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

struct MultiDatePickerView: View {
    @ObservedObject var viewModel: BudgetViewModel
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var years: [String] {
        (0..<10).map { String(currentYear + $0) }
    }
    
    var body: some View {
        VStack {
            if viewModel.selectedBudgetTypeOption.localizedCaseInsensitiveContains("monthly"){
                VStack {
                    Picker(selection: $viewModel.selectedMonthIndex, label: Text("Select a Month")) {
                        ForEach(0..<12) { index in
                            Text(self.months[index]).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden() // Hide the label for cleaner UI
                    .padding()
                    
                    Text("You selected: \(months[viewModel.selectedMonthIndex])")
                        .padding()
                }
                .onDisappear {
                    viewModel.datePicked = months[viewModel.selectedMonthIndex]
                }
            }
            
            if viewModel.selectedBudgetTypeOption.localizedCaseInsensitiveContains("yearly"){
                VStack {
                    Picker(selection: $viewModel.selectedYearlyIndex, label: Text("Select a Year")) {
                        ForEach(0..<10) { index in
                            Text(self.years[index]).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden() // Hide the label for cleaner UI
                    .padding()
                    
                    Text("You selected: \(years[viewModel.selectedYearlyIndex])")
                        .padding()
                }
                .onDisappear {
                    viewModel.datePicked = years[viewModel.selectedYearlyIndex]
                }
            }
            
            if viewModel.selectedBudgetTypeOption.localizedCaseInsensitiveContains("weekly"){
                VStack {
                    Picker(selection: $viewModel.selectedWeeklyMonthIndex, label: Text("Select a Month")) {
                        ForEach(0..<12) { index in
                            Text(self.months[index]).tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden() // Hide the label for cleaner UI
                    .padding()
                    
                    Text("You selected: \(months[viewModel.selectedWeeklyMonthIndex])")
                        .padding()
                   
                }
                .onDisappear {
                    if !viewModel.dateRange.isEmpty {
                        viewModel.datePicked = "\(months[viewModel.selectedWeeklyMonthIndex]), \(viewModel.dateRange)"
                    }
                }
                CalendarView(selectedMonth: viewModel.selectedWeeklyMonthIndex + 1, viewModel: viewModel)
            }
        }
    }
}

struct CalendarView: View {
    let calendar = Calendar.current
    let selectedMonth: Int
    @ObservedObject var viewModel: BudgetViewModel
    
    func generateCalendarGridItems(month: Int) -> [String] {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        // Get the date for the given year and month
        guard let dateForMonth = calendar.date(from: DateComponents(year: year, month: month)),
            let daysInMonth = calendar.range(of: .day, in: .month, for: dateForMonth)?.count else {
                fatalError("Failed to calculate days in the selected month.")
        }
        
        // Get the first day of the month and its weekday
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // Prepare the grid items
        var gridItems: [String] = []
        
        // Add empty cells for days before the first day of the month
        gridItems.append(contentsOf: Array(repeating: "", count: weekday - 1))
        
        // Add day numbers to the grid
        gridItems.append(contentsOf: (1...daysInMonth).map { String($0) })
        
        return gridItems
    }
    
    var body: some View {
        
        let gridItems = generateCalendarGridItems(month: selectedMonth)
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7), content: {
            Text("S").frame(width: 40, height: 40)
            Text("M").frame(width: 40, height: 40)
            Text("T").frame(width: 40, height: 40)
            Text("W").frame(width: 40, height: 40)
            Text("T").frame(width: 40, height: 40)
            Text("F").frame(width: 40, height: 40)
            Text("S").frame(width: 40, height: 40)
            
            ForEach(gridItems, id: \.self) { gridItem in
                if gridItem.isEmpty {
                    Text("")
                        .frame(width: 40, height: 40)
                } else {
                    Button {
                        guard let day = Int(gridItem) else { return }
                        viewModel.didSelectDate(day)
                    } label: {
                        Text(gridItem)
                            .frame(width: 40, height: 40)
                            .border(Color.black, width: 1)
                            .background(
                                (viewModel.startDate == Int(gridItem) || viewModel.endDate == Int(gridItem))
                                ? Color.blue.opacity(0.3)
                                : Color.clear
                            )
                    }
                }
            }
        })
        .padding()
    }
}


extension DateFormatter {
    static var shortDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
}


struct SecondView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 480, sheetHeight: 456, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")], headerContent: {}){
                    VStack(spacing: 0) {
                        Spacer()
                        Text("Set Amount")
                            .font(.system(size: 22, weight: .medium))
                        VStack(spacing: 0) {
                            BottomLineTextFieldView(
                                label: "",
                                placeholder: "0.00",
                                alignCetner: true,
                                textInputVal: $viewModel.textInputAmountVal
                            )
                                .keyboardType(.decimalPad)
                                .frame(width: 150)
                            if let error = viewModel.errorInputAmount {
                                Text("\(error)")
                                    .foregroundStyle(Color("ColorCherryRed"))
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding(.bottom, 3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 20)
                            }
                        }.padding()
                        HStack (spacing: 10) {
                            Button {
                                viewModel.textInputAmountVal = "150000"
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
                                viewModel.textInputAmountVal = "25000"
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("ColorMistyLavender"))
                                    .frame(height: 46)
                                    .overlay {
                                        Text("\(formatCurrency(value: 25000))")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(Color("ColorVividBlue"))
                                    }
                            }
                            Button {
                                viewModel.textInputAmountVal = "15000"
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
                            if viewModel.validateInputAmount() {
                                if let currentUser = UserManager.shared.getCurrentUser() {
                                    viewModel.submit(currentUser: currentUser)
                                }
                                viewModel.submit(currentUser: User(id: UUID(), name: "", email: "", password: ""))
                            }
                            
                        })
                        .buttonStyle(
                            CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Create", cornerRadius: 16)
                        )
                        Spacer()
                    }.padding()
                }
            }
            .navigationDestination(isPresented: $viewModel.isSubmissionSuccess) {
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
    var iconName: String?
    var fontSize: CGFloat?
    var iconSize: CGFloat?
    
    func makeBody(configuration: Self.Configuration) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(fillColor))
            .frame(width: width, height: height)
            .overlay {
                HStack {
                    if let icon = iconName {
                        Image(systemName: icon)
                            .font(.system(size: iconSize != nil ? iconSize! : 18))
                            .foregroundColor(.white)
                    }
                    Text(label)
                        .font(.system(size: fontSize != nil ? fontSize! : 18, weight: .medium))
                        .foregroundColor(.white)
                }
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
//        NewBudgetView()
        let budget = Budget(
            id: UUID(), name: "name",
            budgetType: BudgetType(type: .yearly, date: .yearOnly(2024), limit: 8000),
            category:
                BudgetCategory(
                    id: UUID(),
                    name: "Rent/Mortage",
                    primaryBackgroundColor: "ColorVividBlue", iconName: ""
                ),
            allocatedAmount: 52362.00,
            currentAmountSpent: 12283.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: false),
            transactions: []
        )
        NewBudgetView(budget: budget)
    }
}
