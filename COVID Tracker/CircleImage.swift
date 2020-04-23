//
//  CircleImage.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/16/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
		Image("Machu Picchu") //grabs our turtlerock.jpg image file
			.clipShape(Circle()) //adds circular crop to image
			.overlay(Circle()
				.stroke(Color.white, lineWidth: 4))
			.shadow(radius:10)
		//creates circle with white outline and is added as an overlay to image to give it border, adds shadow of 10 point radius
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
