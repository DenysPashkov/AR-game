//
//  UICollectionView.swift
//  AR try 0.1
//
//  Created by denys pashkov on 20/11/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit
import Foundation

class MemeLibraryController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var bordImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var cellNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setCells()
        
    }
    
    //    MARK: - setting cells
    func setCells() {
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 100)/2, height: (self.collectionView.frame.size.height - 100)/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeDatabase.memeDict.keys.count /// return the amount of memes stored to set the amount of cells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MemeCell
        
        
        cell.tag = cellNumber
        cell.memeAllocated = memeDatabase.memeDict[cellNumber]!
        cell.memeName.text = cell.memeAllocated!.name
        cell.memeName.layer.zPosition = 20
        
        //        print(cell.tag)
        
        
        if !cell.memeAllocated!.found { /// meme was not found yet, show greyed border and hint
            cell.memeHint.text = cell.memeAllocated!.hint /// add hint on how to find meme below "Can't find it?" text
            cell.memeHint.layer.zPosition = 20
            cell.memeImageView.image = UIImage(named: "404NotFound.jpeg") /// put placeholder image
            
        } else { /// meme was found, don't show hint and show image
            cell.memeFrame.image = UIImage(named: "collected.png")
            cell.memeImageView.image = UIImage(named: cell.memeAllocated!.imageName)
            cell.staticHintText.text = "" /// remove "Can't find it?" text
            cell.staticHintText.layer.zPosition = 39
            
        }
        
        cellNumber += 1
        
        return cell
        
    }
    
    //    MARK: - Call the performSegue here
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if memeDatabase.memeDict[cell.tag]!.found { /// only show popup if a found meme was clicked
            performSegue(withIdentifier: "toInformation", sender: cell)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toInformation"{
            
            let nextScreen = segue.destination as! MemeInformationPopupController
            nextScreen.popUpMeme = memeDatabase.memeDict[(sender as AnyObject).tag as Int]!
        }
    }
}
