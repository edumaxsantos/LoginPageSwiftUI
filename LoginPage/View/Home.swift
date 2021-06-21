//
//  Home.swift
//  LoginPage
//
//  Created by Eduardo Santos on 20/06/21.
//

import SwiftUI

struct Home: View {
    

    
    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSignUp = false
    
    var body: some View {
        VStack {
            
            GeometryReader { proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0 {
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                    ZStack {
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: getRect().width / 2, y: -height / 1.3)
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: -getRect().width / 2, y: -height / 1.5)
                        Circle()
                            .fill(Color("lightBlue"))
                            .offset(y: -height / 1.5)
                            .rotationEffect(.init(degrees: -5))
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
            ZStack {
                if showSignUp {
                    SignUp()
                        .transition(.move(edge: .trailing))
                } else {
                    Login()
                        .transition(.move(edge: .trailing))
                }
            }
            .padding(.top, -maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Text(showSignUp ? "Already Member" : "New Member")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation {
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "sign in" : "sign up")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("lightBlue"))
                })
            }
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 0)
            .offset(y: getSafeArea().bottom - 30)
            ,alignment: .bottom
        )
        .background(
            HStack {
                Circle()
                    .fill(Color("lightBlue"))
                    .frame(width: 70, height: 70)
                    .offset(x: -30, y: getRect().height < 750 ? 10 : 0)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Circle()
                    .fill(Color("dark"))
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
            .offset(y: getSafeArea().bottom + 30)
            ,alignment: .bottom
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
