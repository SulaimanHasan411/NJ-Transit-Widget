import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let widgetWidth = geometry.size.width
            let widgetHeight = geometry.size.height
            
            VStack {
                // Title
                Text("New Brunswick")
                    .font(.system(size: widgetHeight * 0.11, weight: .bold, design: .default))
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: widgetHeight * 0.12)
                    .padding(.bottom, widgetHeight * 0.05)
                VStack(spacing: widgetHeight * 0.1) {
                    // First Train Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.9))
                            .shadow(radius: 5)
                        
                        VStack {
                            HStack(spacing: 2){
                                Text("to")
                                    .foregroundColor(.red)
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                Text("New York -SEC")
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: widgetHeight * 0.1)
                            }
                            
                            HStack(spacing: 0) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("4 mins")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 4)
                            }
                        }
                        .padding(widgetHeight * 0.02)
                    }
                    .frame(width: widgetWidth * 0.9, height: widgetHeight * 0.25)
                    
                    // Second Train Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.9))
                            .shadow(radius: 5)
                        
                        VStack {
                            HStack(spacing: 2){
                                Text("to")
                                    .foregroundColor(.red)
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                Text("Trenton")
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: widgetHeight * 0.1)
                            }
                            
                            HStack(spacing: 0) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("9 mins")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 4)
                            }
                        }
                        .padding(widgetHeight * 0.02)
                    }
                    .frame(width: widgetWidth * 0.9, height: widgetHeight * 0.25)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
