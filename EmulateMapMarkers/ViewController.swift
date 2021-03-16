//
//  ViewController.swift
//  EmulateMapMarkers
//
//  Created by Don Mag on 3/16/21.
//

import UIKit

class ViewController: UIViewController {

	// sample marker data
	let pts: [CGPoint] = [
		CGPoint(x:  200, y:  200),
		CGPoint(x:  800, y:  300),
		CGPoint(x:  500, y:  700),
		CGPoint(x: 1100, y:  900),
		CGPoint(x:  300, y: 1200),
		CGPoint(x: 1300, y: 1400),
	]
	let colors: [UIColor] = [
		.systemRed, .systemBlue, .init(red: 0.0, green: 0.25, blue: 0.0, alpha: 1.0),
		.black, .brown, .systemIndigo,
	]

	var sampleMarkers: [MarkerStruct] = []

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func showMap(_ sender: Any) {
		
		guard let b = sender as? UIButton,
			  let t = b.currentTitle
		else {
			return
		}
		
		if let vc = storyboard?.instantiateViewController(withIdentifier: "markersVC") as? MarkersZoomViewController {

			switch t {
			case "Square":
				vc.mapName = "gridSquare"
				// uses all 6 markers
				let titles: [String] = [
					"First", "Second", "The Third Title",
					"Fourth", "Fifth", "Sixth",
				]
				var m: [MarkerStruct] = []
				for (i, s) in zip([0, 1, 2, 3, 4, 5], titles) {
					// create a Marker Object
					let mrkr = MarkerStruct(title: s, color: colors[i], point: pts[i])
					// append Marker Object to array
					m.append(mrkr)
				}
				vc.markers = m
			case "Wide":
				vc.mapName = "gridWide"
				// uses first 3 markers
				let titles: [String] = [
					"First", "Second", "The Third Title",
				]
				var m: [MarkerStruct] = []
				for (i, s) in zip([0, 1, 2], titles) {
					// create a Marker Object
					let mrkr = MarkerStruct(title: s, color: colors[i], point: pts[i])
					// append Marker Object to array
					m.append(mrkr)
				}
				vc.markers = m
			case "Narrow":
				vc.mapName = "gridNarrow"
				// uses all 1st, 3rd and 5th markers
				let titles: [String] = [
					"First", "Second", "The Third Title",
				]
				var m: [MarkerStruct] = []
				for (i, s) in zip([0, 2, 4], titles) {
					// create a Marker Object
					let mrkr = MarkerStruct(title: s, color: colors[i], point: pts[i])
					// append Marker Object to array
					m.append(mrkr)
				}
				vc.markers = m
			case "Pearl":
				vc.mapName = "pearl3"
				// just one marker
				var m: [MarkerStruct] = []
				let mrkr = MarkerStruct(title: "Pearl Title", color: .yellow, point: CGPoint(x: 1000, y: 1000))
				m.append(mrkr)
				vc.markers = m
			default:
				()
			}

			navigationController?.pushViewController(vc, animated: true)
		}

		
	}
	

}

