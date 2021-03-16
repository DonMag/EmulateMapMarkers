//
//  MarkerView.swift
//  EmulateMapMarkers
//
//  Created by Don Mag on 3/16/21.
//

import UIKit

class MarkerView: UIView {
	
	// "dot" image width and height
	let imgViewWidth: CGFloat = 16
	let imgViewHeight: CGFloat = 16
	
	// label horizontal offset
	let hSpace: CGFloat = 4
	// label bottom will be imgView vertical center
	
	let imgView = UIImageView()
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() -> Void {
		[imgView, label].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		label.font = .systemFont(ofSize: 14.0, weight: .bold)
		
		// find a symbol you like, or use an image
		let img = UIImage(systemName: "circle.fill")
		imgView.image = img
		
		// use constraints to position the image view and label
		NSLayoutConstraint.activate([
			
			// circle image view
			imgView.widthAnchor.constraint(equalToConstant: imgViewWidth),
			imgView.heightAnchor.constraint(equalToConstant: imgViewHeight),
			// position at bottom-left corner
			imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			// label to the right of the circle
			label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: hSpace),
			// label bottom equal to image view centerY
			label.bottomAnchor.constraint(equalTo: imgView.centerYAnchor, constant: 0.0),
			
		])
	}
	
	func setProps(_ mData: MarkerStruct) -> Void {
		imgView.tintColor = mData.color
		label.text = mData.title
		label.textColor = mData.color
		// because the MarkerView itself will NOT be using constraints,
		//	tell the label to size itself
		label.sizeToFit()
		// NOTE: we're using hard-coded absolute values
		//	more likely, these would be calculated values
		// Width is width-of-circle + space + width-of-label
		let w = imgViewWidth + hSpace + label.frame.width
		// Height is half-of-imageViewHeight + height-of-label
		let h = imgViewHeight * 0.5 + label.frame.height
		// set the frame of self
		self.frame.size = CGSize(width: w, height: h)
	}
}
