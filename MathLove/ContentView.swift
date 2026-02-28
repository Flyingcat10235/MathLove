import SwiftUI

struct ContentView: View {
    var body: some View {
        MathLoveView()
    }
}

struct MathLoveView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("ALL YOU NEED IS")
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.bottom, 20)
            
            // 移除所有的 offset，讓四個圖形的灰色座標軸自然對齊成一條完美的水平線
            HStack(spacing: 30) {
                GraphView(drawFunction: pathL)
                GraphView(drawFunction: pathO)
                GraphView(drawFunction: pathV)
                GraphView(drawFunction: pathE)
            }
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    func pathL(in rect: CGRect) -> Path {
        var path = Path()
        let scale = rect.width / 10
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var first = true
        for x in stride(from: 0.15, through: 5.0, by: 0.05) {
            let y = 1.0 / x
            let px = center.x + CGFloat(x) * scale
            let py = center.y - CGFloat(y) * scale
            
            if first {
                path.move(to: CGPoint(x: px, y: py))
                first = false
            } else {
                path.addLine(to: CGPoint(x: px, y: py))
            }
        }
        return path
    }
    
    func pathO(in rect: CGRect) -> Path {
        var path = Path()
        let scale = rect.width / 10
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let xRadius = CGFloat(3.0) * scale
        let yRadius = CGFloat(4.0) * scale
        
        path.addEllipse(in: CGRect(x: center.x - xRadius,
                                   y: center.y - yRadius,
                                   width: xRadius * 2,
                                   height: yRadius * 2))
        return path
    }
    
    func pathV(in rect: CGRect) -> Path {
        var path = Path()
        let scale = rect.width / 10
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var first = true
        for x in stride(from: -3.0, through: 3.0, by: 0.1) {
            let y = abs(-2.0 * x)
            let px = center.x + CGFloat(x) * scale
            let py = center.y - CGFloat(y) * scale
            
            if first {
                path.move(to: CGPoint(x: px, y: py))
                first = false
            } else {
                path.addLine(to: CGPoint(x: px, y: py))
            }
        }
        return path
    }
    
    func pathE(in rect: CGRect) -> Path {
        var path = Path()
        let scale = rect.width / 10
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var first = true
        // 將範圍調整為 -π 到 π，這樣畫出來的 E 就會跟項鍊上一模一樣只有兩個波峰
        for y in stride(from: -Double.pi, through: Double.pi, by: 0.05) {
            let x = -3.0 * abs(sin(y))
            let px = center.x + CGFloat(x) * scale
            let py = center.y - CGFloat(y) * scale
            
            if first {
                path.move(to: CGPoint(x: px, y: py))
                first = false
            } else {
                path.addLine(to: CGPoint(x: px, y: py))
            }
        }
        return path
    }
}

struct GraphView: View {
    var drawFunction: (CGRect) -> Path
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let w = geometry.size.width
                    let h = geometry.size.height
                    
                    path.move(to: CGPoint(x: 0, y: h / 2))
                    path.addLine(to: CGPoint(x: w, y: h / 2))
                    
                    path.move(to: CGPoint(x: w / 2, y: 0))
                    path.addLine(to: CGPoint(x: w / 2, y: h))
                }
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                
                drawFunction(geometry.frame(in: .local))
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            }
        }
        .frame(width: 80, height: 80)
    }
}

#Preview {
    ContentView()
}
