//
//  WelcomeScreen.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-01.
//

import SwiftUI

struct WelcomeView: View {
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State var isAnimating: Bool = false
    @State var isSignInViewActive: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .frame(width: 400, height: 637)
                .overlay {
                    Image("welcome-screen")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.3)
                }
            VStack {
                Spacer()
                VStack {
                    Text("Hey Bigwig!")
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 15)
                    Text("let’s hunt down your expenses for a brighter financial future.")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 15)
                Spacer()
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color("ColorVioletBlue"))
                        .padding(8)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    HStack {
                        Capsule()
                            .fill(Color("ColorVioletBlue"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorGoldenrod"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isSignInViewActive = true
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        .navigationDestination(isPresented: $isSignInViewActive) {
                            SigninView()
                        }
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(.vertical, 6)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                Text("Version 1.0")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(.bottom, 25)
            }
            .onAppear(perform: {
                isAnimating = true
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color("ColorElectricIndigo"), Color("ColorCerulean")]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .ignoresSafeArea(edges: .all)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
