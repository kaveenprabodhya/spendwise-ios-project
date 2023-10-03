//
//  OnboardingView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-30.
//

import SwiftUI

struct OnboardingSlide: Hashable, Identifiable {
    let id: UUID
    let imageName: String
    let dropColor: String
    let heading: String
    let content: String
}

struct OnboardingView: View {
    let onboardingSlideArray: [OnboardingSlide] = [
        OnboardingSlide(id: UUID(), imageName: "tutorial-goal", dropColor: "ColorDeepMustard", heading: "Set your financial goals", content: "Say goodbye to financial stress and hello to financial clarity with SpendWise."),
        OnboardingSlide(id: UUID(), imageName: "tutorial-tips", dropColor: "ColorFernGreen", heading: "Follow our tips ans tricks", content: "Navigate your way to financial success with SpendWise as your guide."),
        OnboardingSlide(id: UUID(), imageName: "tutorial-secure", dropColor: "ColorTurquoiseBlue", heading: "Secure and Trusted", content: "Your financial peace of mind is our priority. Trust the stability and security of our app for a worry-free experience."),
        OnboardingSlide(id: UUID(), imageName: "tutorial-rocket", dropColor: "ColorPeriwinkleBlue", heading: "Fast and Reliable", content: "Speedy transactions, trustworthy security, and dependable performance – our app has it all.")
    ]
    @State var indexTab: Int = 0
    @State var isOnSkipOrSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $indexTab) {
                    ForEach(onboardingSlideArray.indices, id:\.self) { index in
                        SlideView(imageName: onboardingSlideArray[index].imageName, dropColor: Color(onboardingSlideArray[indexTab].dropColor), heading: onboardingSlideArray[indexTab].heading, content: onboardingSlideArray[indexTab].content, indexTab: $indexTab, onboardingSlideArray: onboardingSlideArray, isOnSkipOrSuccess: $isOnSkipOrSuccess)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .disabled(true)
                .navigationDestination(isPresented: $isOnSkipOrSuccess, destination: {
                    WelcomeView()
                })
                .ignoresSafeArea(edges: .bottom)
                VStack {
                    Text("Skip")
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 15)
                        .onTapGesture {
                            isOnSkipOrSuccess = true
                        }
                    Spacer()
                    HStack {
                        HStack {
                            ForEach(onboardingSlideArray.indices, id:\.self) { index in
                                if index == indexTab {
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color("ColorVividBlue"))
                                        .frame(width: 22, height: 10)
                                } else {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 10, height: 10)
                                }
                            }
                        }
                        Spacer()
                        Button {
                            if indexTab < (onboardingSlideArray.count - 1) {
                                indexTab += 1
                            } else {
                                isOnSkipOrSuccess = true
                            }
                        } label: {
                            Circle()
                                .fill(Color("ColorVividBlue"))
                                .frame(width: 90,height: 90)
                                .overlay {
                                    Image(systemName: "arrow.forward")
                                        .font(.system(size: 48))
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                .padding(.bottom, 20)
                }
            }
            
        }
    }
}

struct SlideView: View {
    var imageName: String
    var dropColor: Color
    var heading: String
    var content: String
    @Binding var indexTab: Int
    var onboardingSlideArray: [OnboardingSlide]
    @Binding var isOnSkipOrSuccess: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(imageName)")
                .resizable()
                .scaledToFit()
                .frame(width: 383, height: 361)
            VStack {
                UnevenRoundedRectangleViewShape(topLeftRadius: 25, topRightRadius: 25, bottomLeftRadius: 0, bottomRightRadius: 0)
                    .fill(dropColor)
                    .frame(height: 416)
                    .overlay {
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text(heading)
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .padding(.top, 30)
                                    .padding(.bottom, 120)
                                Text(content)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 15)
                            }
                            Spacer()
                            
                        }
                    }
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    OnboardingView()
}
