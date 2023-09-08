import Foundation
import SwiftUI

struct PulsatingView: View {
    @Environment(\.colorScheme) var colorScheme
    
//    @State public var x: CGFloat
    @State public var y: CGFloat
    
    @State private var isPulsing = false
    @State public var opacity: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.accent)
                .scaleEffect(isPulsing ? 1.3 : 0.9)
                .opacity(isPulsing ? 0.0 : 1.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(Animation.easeIn(duration: 0.9).repeatForever(autoreverses: false)) {
                            self.isPulsing = true
                        }
                    }
                    withAnimation(Animation.easeIn(duration: 0.7)) {
                        self.opacity = 1.0
                    }
                }
                .onDisappear {
                    withAnimation(Animation.easeIn(duration: 0.7)) {
                        self.opacity = 0.0
                    }
                }
                .opacity(opacity)
            Circle()
                .fill(.accent)
                .opacity(opacity)
        }
        .frame(width: 220)
        .offset(x: 0, y: y)
//        .ignoresSafeArea()
    }
}


#Preview {
    PulsatingView(y: 0)
}
