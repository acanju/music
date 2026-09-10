//
//  BarWaveView.swift
//  SoundWave
//
//  Created by Anju on 24/04/25.
//


import UIKit

class BarWaveView: UIView {
    var numberOfBars = 120
    var barWidth: CGFloat = 2
    var space: CGFloat = 5    
    var amplitude: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var barHeights: [CGFloat] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBars()
    }
    
    private func setupBars() {
        barHeights = (0..<numberOfBars).map { _ in CGFloat.random(in: 0.3...1.0) }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.clear(rect)
        let midY = rect.height / 2
        
        for i in 0..<numberOfBars {
            let x = CGFloat(i) * (barWidth + space)
            let dynamicHeight = barHeights[i] * amplitude * rect.height * 0.9
            let y = midY - dynamicHeight / 2
            
            let barRect = CGRect(x: x, y: y, width: barWidth, height: dynamicHeight)
            let path = UIBezierPath(roundedRect: barRect, cornerRadius: barWidth / 2)
            UIColor.red.setFill()
            path.fill()
        }
    }
    
    func updateAmplitude(_ newAmplitude: CGFloat) {
        amplitude = newAmplitude
        barHeights = barHeights.map { _ in CGFloat.random(in: 0.4...1.0) }
    }
}
