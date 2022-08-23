//
//  NetWorkingProvider.swift
//  AlkemyChallenge
//
//  Created by Manuel Moyano on 16/08/2022.
//

import Foundation
import Alamofire

final class NetWorkingProvider {
    
    static let shared = NetWorkingProvider()
    private init(){}
    
    private let apiKey = "adbba095f2045455a8907182acd1ab46"
    private let kStatusOk = 1...499
    private let kBaseUrl = "https://api.themoviedb.org/3/movie/popular?"
    private let kBaseSearch = "&language=en-US&page=1"
    private let idAccount = 12426733
    
//    PRUEBA DE DATOS
    private let pSessionId = "6e64c9a790fa06f6015b0a72a0e487af333ce9b1"
    private let pToken = "d2afb63299537fa04415033993ad0d201be7f6a8"
    
    func getTokenAlamofire (success: @escaping (_ token: TokenRequest) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        let url = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: TokenRequest.self) {  response in
            
            if let token = response.value {
                success(token)
                print("Se genero el TOKEN")
                print("El Token es: \(token.request_token)")
            } else {
                print("No se genero el Token por el error \(String(describing: response.error))")
                failure(response.error)
            }
        }
    }
    
    
    func creatSessionID(token: TokenRequest, success: @escaping (_ sessionId: SessionIdRequest) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)"
        let tokenPost: TokenPost = TokenPost(request_token: token.request_token )
        
        AF.request(url, method: .post, parameters: tokenPost, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusOk).responseDecodable (of: SessionIdRequest.self) {  response in
            
            if let sessionId = response.value {
                success(sessionId)
                print("La Session id es: \(String(describing: sessionId.session_id))")
            } else {
                print(response.error ?? "No error description founded")
                print("No se consiguio la Session")
                failure(response.error)
            }
        }
    }
    
    
    func loadAllMoviesAlamofire (success: @escaping (_ movies: Response) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        let url = "\(kBaseUrl)api_key=\(apiKey)\(kBaseSearch)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: Response.self) {  response in
            
            if let movies = response.value {
                success(movies)
            } else {
                failure(response.error)
            }
        }
    }
    
    
    func addFavAlamofire(newFav: NewFavorite, success: @escaping (_ fav: NewFavoriteResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
//        Recordar modificar la variable sessionId por la generada en el acceso a la         app y el account id
        let url = "https://api.themoviedb.org/3/account/12426733/favorite?api_key=\(apiKey)&session_id=\(UserDefaultsFunctions.shared.sessionId!.session_id)"
        
        
        let headers: HTTPHeaders = [.contentType("application/json;charset=utf-8")]
        
        AF.request(url, method: .post, parameters: newFav, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: NewFavoriteResponse.self) {  response in
            
            if let newFavResponse = response.value {
                success(newFavResponse)
                print("Se añadio a favorito")
                print("\(String(describing: newFavResponse.status_message))")
            } else {
                failure(response.error)
                print ("No se pudo añadir a favoritos")
                print (response.error ?? "No hay descripcion del error")
            }
        }
    }
    
    func getFavAlamorife (success: @escaping (_ listFav: ListFavorites) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        let url = "https://api.themoviedb.org/3/account/12426733/favorite/movies?api_key=adbba095f2045455a8907182acd1ab46&session_id=6e64c9a790fa06f6015b0a72a0e487af333ce9b1&language=en-US&sort_by=created_at.asc&page=1"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: ListFavorites.self) {  response in
            
            if let listFav = response.value {
                success(listFav)
            } else {
                failure(response.error)
            }
        }
    }
    
    func ratemovie (movie: Int, value: NewRate, success: @escaping (_ rate: RateResponse)->(), failure: @escaping (_ error: Error?)->()){
        let url = "https://api.themoviedb.org/3/movie/\(movie)/rating?api_key=\(apiKey)&session_id=\(pSessionId)"

        
        let headers: HTTPHeaders = [.contentType("application/json;charset=utf-8")]
        
        AF.request(url, method: .post, parameters: value, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable(of: RateResponse.self) { response in
            
            if let rateResponse = response.value {
                success(rateResponse)
            } else {
                failure(response.error)
            }
        }
    }
    
    
    
    
}
