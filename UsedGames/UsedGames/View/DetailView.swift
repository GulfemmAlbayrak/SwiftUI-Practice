//
//  DetailView.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 6.08.2024.
//

import SwiftUI
import Combine

struct DetailView: View {
    
    var game: Game
    var gameStore: GameStore
    var imageStore: ImageStore 
    
    @State var name: String = ""
    @State var price: Double = 0.0
    
    @State var shouldEnableSaveButton: Bool = false
    @State var isPhotoPickerPresenting: Bool = false
    @State var isPhotoPickerActionSheetPresenting: Bool = false
    
    @State var selectedPhoto: UIImage?
    
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func validate() {
        let isPhotoUpdated = imageStore.image(forKey: game.itemKey) == selectedPhoto
        
        shouldEnableSaveButton = game.name != self.name || game.priceInDollars != price || isPhotoUpdated
    }
    
    func createActionSheet() -> ActionSheet {
        var buttons: [ActionSheet.Button] = [
            .cancel()
        ]
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            buttons.append(
                .default(Text("Camera"),
                         action: {
                             sourceType = .camera
                             isPhotoPickerPresenting = true
                         }
                    )
                )
            }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            buttons.append(
                .default(Text("Photo Library"),
                         action: {
                             sourceType = .photoLibrary
                             isPhotoPickerPresenting = true
                         }
                    )
                )
            }
        return ActionSheet(title: Text("Please select a source"), message: nil, buttons: buttons)
        }
    
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Name")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: name, perform: { newValue in
                            validate()
                        })
                }
                .padding(.vertical, 4.0)
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Price in Dollars")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextField("Price", value: $price, formatter: Formatters.dollarFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: price, perform: { newValue in
                            validate()
                        })
                }
                .padding(.vertical, 4.0)
            }
            if let selectedPhoto = selectedPhoto {
                Section(header: Text("Image")) {
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                        .overlay(Button(action: {
                            imageStore.deleteImage(forKey: game.itemKey)
                        }, label: {
                           Image(systemName: "trash")
                        }), alignment: .topTrailing)
                }
            }
            Section {
                Button(action: {
                    let newGame = Game(name: name, priceInDollars: price, serialNumber: game.serialNumber)
                    gameStore.update(game: game, newValue: newGame)
                    if let selectedPhoto {
                        imageStore.setImage(selectedPhoto, forKey: game.itemKey)
                    } else {
                        imageStore.deleteImage(forKey: game.itemKey)
                    }
                    
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50.0)
                })
                .disabled(!shouldEnableSaveButton)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: {
                    
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        isPhotoPickerActionSheetPresenting = true
                    } else {
                        isPhotoPickerPresenting = true
                    }
                }, label: {
                    Image(systemName: "camera")
                })
            }
        }
        .actionSheet(isPresented: $isPhotoPickerActionSheetPresenting, content: {
            createActionSheet()
        })
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPhotoPickerPresenting, content: {
            PhotoPicker(sourceType: sourceType, imageStore: imageStore, game: game, selectedPhoto: $selectedPhoto)
                .onReceive(Just(selectedPhoto), perform: { newValue in
                    validate()
                })
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let gameStore = GameStore()
        let imageStore = ImageStore()
        let game = gameStore.createGame()
        DetailView(
            game: game,
            gameStore: gameStore,
            imageStore: imageStore)
    }
}
