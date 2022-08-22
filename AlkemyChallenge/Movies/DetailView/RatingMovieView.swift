//
//  RatingMovieView.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 18/08/2022.
//

import SwiftUI

struct RatingMovieView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var movie: Int
    @State var rating: Int
    
    var body: some View {
        ZStack{
            Color.black
            VStack{
                Button {
                    NetWorkingProvider.shared.ratemovie(movie: movie, value: NewRate(value: Float(rating))) { rate in
                        print("Se califico OK con la nota \(rate)")
                    } failure: { error in
                        print("No se califico por el error \(error!)")
                    }
                    dismiss()

                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "hand.thumbsup")
                        .foregroundColor(.white)
                }                  .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                    )
                .padding()
                RatingView(rating: $rating)

            }
        }
    }
}

struct RatingMovieView_Previews: PreviewProvider {
    static var previews: some View {
        RatingMovieView(movie: 550, rating: 7)
    }
}
