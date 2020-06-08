//
//  SceneManager.swift
//  AR try 0.1
//
//  Created by denys pashkov on 13/11/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit
import Foundation

class MemesClass {
    
    var memeDict: [Int:Meme] = [
        0:
            Meme(imageName: "box", description: "Roll Safe is an image macro series featuring a screenshot of actor Kayode Ewumi grinning and pointing to his temple while portraying the character Reece Simpson (a.k.a. \"Roll Safe\") in the web series Hood Documentary. The images are often captioned with various jokes mocking poor decision making and failures in critical thinking.", name: "Roll Safe", hint: "Pack it!"),
        1:
            Meme(imageName: "bottle", description: "Pepe the Frog is an anthropomorphic frog character from the comic series Boy’s Club by Matt Furie. On 4chan, various illustrations of the frog creature have been used as reaction faces, including Feels Doog Man, Sad Frog, Angry Pepe, Smug Frog and Well Meme'd.", name: "Pepe the frog", hint: "You’d need a genie…"),
        2:
            Meme(imageName: "guitar", description: "Great Gatsby Reaction refers to a series of reaction images featuring Leonardo DiCaprio as Jay Gatsby toasting a martini glass from the 2013 film The Great Gatsby.", name: "Great Gatsby Reaction", hint: "Look for 6 chordes."),
        3:
            Meme(imageName: "trash", description: "The One does not simply meme usually features a screenshot of Sean Bean as Boromir, especially a still of the actor making a circular, eye shape with his hand. At the top of the image is the caption One does not simply followed by text on the bottom that replaces the rest of the film’s line “walk into Mordor” with a different,  usually humorous phrase.", name: "One does not simply", hint: "Trash it."),
        4:
            Meme(imageName: "water", description: "Cursed Cat, refers to an image of a black cat crossing a road, photoshopped in a cursed manner.It has become a trend amongRussian users.", name: "Cursed Cat", hint: "Look for some water!"),
        5:
            Meme(imageName: "tablet", description: "\"Shut up and take my money!\" is a catchphrase used to express enthusiastic approval toward a product or idea. It is often associated with an image macro featuring the character Fry from the animated television series Futurama.", name: "Shut up and take my money ", hint: "Look for a tablet!")
    ]
    
    // save the index for the found meme in plist
    func storeFoundMeme(){
        
        var foundList : [Bool] = []
        
        let defaults = UserDefaults.standard
        for index in 0...memeDatabase.memeDict.count - 1 {
                
                foundList.insert(memeDatabase.memeDict[index]!.found, at: index)
            
        }
        
        defaults.set(foundList, forKey: "FoundMemes")
        
    }
    
    // load found memes from plist file and set found to true
    func loadFoundMemes() {
        
        let defaults = UserDefaults.standard
        let seenMeme = defaults.array(forKey: "FoundMemes") as? [Bool] ?? []
        
        if seenMeme.count == 0 {
            
            for index in 0...memeDatabase.memeDict.count - 1 {
                
                memeDatabase.memeDict[index]!.found = false
                
            }
        } else {
            
            for index in 0...memeDatabase.memeDict.count - 1 {
                
                memeDatabase.memeDict[index]!.found = seenMeme[index]
                
            }
        }
    }
}

let memeDatabase = MemesClass()
//
