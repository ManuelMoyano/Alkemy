//
//  RatingView.swift
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var maximumRating = 10
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    var body: some View {
        
        HStack {
            ForEach(1...maximumRating, id: \.self) { number in
                onImage
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                        print (rating)
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
