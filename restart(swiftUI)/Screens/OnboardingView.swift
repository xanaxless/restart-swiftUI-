//
//  OnboardingView.swift
//  restart(swiftUI)
//
//  Created by Yerkebulan Serikov on 15.04.2022.
//

import Foundation
import SwiftUI

struct OnboardingView: View{
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOfset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            
            VStack(spacing: 20){
                
                Spacer()
                
                VStack(spacing:0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
It's not how much we give but
how much love we put into giving
""")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                ZStack{
                    CircleGroupView(shapeColor: .white , shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width)/5)
                        .animation(.easeOut(duration:1), value: imageOffset)
                    
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: 1.2 * imageOffset.width)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                if(abs(imageOffset.width) <= 120) {
                                    imageOffset = gesture.translation
                                    withAnimation(.linear(duration: 0.25))
                                    {
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    }
                                }
                            })
                            .onEnded({ _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration: 0.25))
                                {
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            })
                        )
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                }.overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset( y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .opacity(indicatorOpacity)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    , alignment: .bottom
                )
                
                
                Spacer()
                
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    HStack(){
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOfset+80)
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName:"chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOfset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOfset <= buttonWidth - 80{
                                        withAnimation {
                                            buttonOfset = gesture.translation.width
                                        }
                                    }
                            })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 1)) {
                                        if buttonOfset <= buttonWidth/2{
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOfset = 0
                                        }
                                        else{
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOfset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }
                                    }
                                })
                            
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset( y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            } // VStack()
        } // ZStarck()
        .onAppear {
            isAnimating = true
        }
    }
}


struct OnboardingView_Preview: PreviewProvider{
    static var previews: some View {
        OnboardingView()
    }
}
