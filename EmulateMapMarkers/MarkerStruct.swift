//
//  MarkerStruct.swift
//  EmulateMapMarkers
//
//  Created by Don Mag on 3/16/21.
//

import UIKit

struct MarkerStruct {
	var title: String = ""
	var color: UIColor = .black
	var point: CGPoint = .zero
	var xPCT: CGFloat = 0
	var yPCT: CGFloat = 0
	var markerView: MarkerView?
}
