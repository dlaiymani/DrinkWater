//
//  LCTextLayer.swift
//  DrinkWater
//
//  Created by David Laiymani on 04/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class LCTextLayer : CATextLayer {

// REF: http://lists.apple.com/archives/quartz-dev/2008/Aug/msg00016.html
// CREDIT: David Hoerl - https://github.com/dhoerl
// USAGE: To fix the vertical alignment issue that currently exists within the CATextLayer class. Change made to the yDiff calculation.

    override init() {
        super.init()
    }

    override init(layer: Any?) {
        super.init(layer: layer as Any)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(layer: aDecoder)
    }

    override func draw(in ctx: CGContext) {
        let fontSize = self.fontSize
        let height = self.bounds.size.height
        let deltaY = (height-fontSize)/2 - fontSize/10

        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: deltaY)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
