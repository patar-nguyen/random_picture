//
//  ContentView.swift
//  Random_Picture
//
//  Created by Patrick Nguyen on 2022-09-12.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string: "https://picsum.photos/200/300") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
                
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let image = viewModel.image {
                    image
                    .resizable()
                    .foregroundColor(.pink)
                    .frame(width: 250, height: 250)
                    .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(width: 250, height: 250)
                        .padding()
                }
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("New Picture")
                        .bold()
                        .frame(width: 250, height: 50)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(5)
                        .padding()
                        
                })
            }
            .navigationTitle("Random Picture")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
