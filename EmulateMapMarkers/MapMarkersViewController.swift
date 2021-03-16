//
//  MapMarkersViewController.swift
//  EmulateMapMarkers
//
//  Created by Don Mag on 3/16/21.
//

import UIKit

class MarkersZoomViewController: UIViewController, UIScrollViewDelegate {
	
	public var mapName: String = ""

	public var markers: [MarkerStruct] = []

	@IBOutlet var imgView: UIImageView!
	@IBOutlet var label: UILabel!
	@IBOutlet var scrollView: UIScrollView!
	
	@IBOutlet var imageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet var imageViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet var imageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet var imageViewTrailingConstraint: NSLayoutConstraint!
	
	@IBOutlet var imageViewWidthConstraint: NSLayoutConstraint!
	@IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let img = UIImage(named: mapName) else {
			fatalError("Could not load image!!!!")
		}
		
		imgView.image = img
		
		// hide image view (fully transparent) until it's been sized
		imgView.alpha = 0.0
		
		// update image view width and height constraints
		imageViewWidthConstraint.constant = img.size.width
		imageViewHeightConstraint.constant = img.size.height

		// in case it wasn't set in IB
		scrollView.delegate = self

		for i in 0..<markers.count {
			// calculate percentage points
			markers[i].yPCT = markers[i].point.y / img.size.height
			markers[i].xPCT = markers[i].point.x / img.size.width
			// create a Marker View
			let v = MarkerView()
			markers[i].markerView = v
			// this sets the title and color of the marker image and label
			//	setProps() also sets the MarkerView's frame size
			v.setProps(markers[i])
			// append Marker Object to array
			markers.append(markers[i])
			// add Marker View to scrollView
			scrollView.addSubview(v)
			// don't want to see them until we're ready
			v.alpha = 0.0
		}

	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate(alongsideTransition: { _ in
			self.updateMinZoomScaleForSize(size, shouldSize: (self.scrollView.zoomScale == self.scrollView.minimumZoomScale))
			self.updateConstraintsForSize(size)
		}, completion: {
			_ in
		})
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		updateMinZoomScaleForSize(scrollView.bounds.size)
		updateConstraintsForSize(scrollView.bounds.size)
		
		imgView.alpha = 1.0
		
		updateMarkers()
	}
	
	func updateMarkers() -> Void {
		self.markers.forEach { mStruct in
			guard let v = mStruct.markerView else {
				fatalError("Markers were not initialized correctly!")
			}
			// calculate new x,y positions
			let x = self.imgView.frame.origin.x + mStruct.xPCT * self.imgView.frame.width
			let y = self.imgView.frame.origin.y + mStruct.yPCT * self.imgView.frame.height
			
			// offset MarkerView to put the center of the circle
			//	at the center of the coordinates
			let xOffset = v.imgViewWidth * 0.5
			let yOffset = v.frame.height - v.imgViewHeight * 0.5
			v.frame.origin = CGPoint(x: x - xOffset, y: y - yOffset)
			
			v.alpha = 1.0
		}
	}
	
	func updateMinZoomScaleForSize(_ size: CGSize, shouldSize: Bool = true) {
		guard let img = imgView.image else {
			return
		}
		
		let widthScale = size.width / img.size.width
		let heightScale = size.height / img.size.height
		
		let minScale = min(widthScale, heightScale)
		scrollView.minimumZoomScale = minScale
		scrollView.zoomScale = minScale
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		updateConstraintsForSize(scrollView.bounds.size)
		updateMarkers()
	}
	
	func updateConstraintsForSize(_ size: CGSize) {
		let yOffset = max(0, (size.height - imgView.frame.height) / 2)
		imageViewTopConstraint.constant = yOffset
		
		let xOffset = max(0, (size.width - imgView.frame.width) / 2)
		imageViewLeadingConstraint.constant = xOffset
		
		view.layoutIfNeeded()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imgView
	}
	
}

