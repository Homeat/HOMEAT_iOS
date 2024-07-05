//
//  CustomPieChartRenderer.swift
//  HOMEAT
//
//  Created by 김민솔 on 7/5/24.
//

import UIKit
import Charts
import DGCharts

class CustomPieChartRenderer: PieChartRenderer {
    override func drawDataSet(context: CGContext, dataSet: PieChartDataSetProtocol) {
        super.drawDataSet(context: context, dataSet: dataSet)
        
        guard let chart = chart else { return }
        
        let phaseX = animator.phaseX
        let phaseY = animator.phaseY
        let rotationAngle = chart.rotationAngle
        let drawAngles = chart.drawAngles
        let absoluteAngles = chart.absoluteAngles
        let center = chart.centerCircleBox
        let radius = chart.radius
        let userInnerRadius = chart.holeRadiusPercent * radius
        
        var angle = rotationAngle
        var i = 0
        
        context.saveGState()
        
        for i in 0..<dataSet.entryCount {
            let entry = dataSet.entryForIndex(i)
            
            if entry?.y == 0 {
                continue
            }
            
            let sliceAngle = drawAngles[i]
            let sliceSpace = dataSet.sliceSpace
            
            let angleOffset = (sliceSpace / (0.017453292)) / 2.0
            
            let sliceStartAngle = rotationAngle + (absoluteAngles[i] - drawAngles[i]) * phaseY + angleOffset
            let sliceEndAngle = sliceStartAngle + sliceAngle * phaseY - angleOffset
            
            let labelRadius = userInnerRadius + (radius - userInnerRadius) / 2
            
            let labelX = labelRadius * cos((sliceStartAngle + sliceEndAngle) / 2 * .pi / 180)
            let labelY = labelRadius * sin((sliceStartAngle + sliceEndAngle) / 2 * .pi / 180)
            
            let percentage = String(format: "%.0f%%", entry?.y ?? 0)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.black
            ]
            let size = percentage.size(withAttributes: attributes)
            let labelRect = CGRect(
                x: center.x + labelX - size.width / 2,
                y: center.y + labelY - size.height / 2,
                width: size.width,
                height: size.height
            )
            let circleDiameter = max(size.width, size.height) + 4 
            let circleRect = CGRect(
                x: center.x + labelX - circleDiameter / 2,
                y: center.y + labelY - circleDiameter / 2,
                width: circleDiameter,
                height: circleDiameter
            )
            
            let circlePath = UIBezierPath(ovalIn: circleRect)
            UIColor.white.setFill()
            circlePath.fill()
            
            percentage.draw(in: labelRect, withAttributes: attributes)
        }
        
        context.restoreGState()
    }
}




