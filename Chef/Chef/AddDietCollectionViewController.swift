//
//  AddDietCollectionViewController.swift
//  Chef
//
//  Copyright © 2017 Blue Team. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AddDietCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var dietsCollectionView: UICollectionView!
    let store = RecipeDataStore.shared
    var dietList = [String]()
    var allergyList = [String]()
    private let restrictions: [String: [String]] = ["diets": ["Vegetarian", "Pescetarian", "Vegan", "Paleo"], "allergies": ["Egg", "Wheat", "Soy", "Dairy", "Peanut", "Sesame", "Gluten", "Shellfish", "Sulfite", "Tree Nut", "Seafood"]]
    
    struct Objects {
        let name: String
        let options: [String]
    }
    
    var objects = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for (key, value) in restrictions {
            let object = Objects(name: key, options: value)
            objects.append(object)
        }
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
        
        createUI()
        let flowLayout = UICollectionViewFlowLayout()
        let dietsCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        dietsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects[section].options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.label.text = objects[indexPath.section].options[indexPath.row]
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let cellSize = CGSize(width: 90, height: 120)
//        //
//        return cellSize
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsetsMake(20, 10, 10, 10)
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func dietButtonTapped(_ button: UIButton) {
        var btnTitle = button.title(for: .selected)
        _ = btnTitle?.characters.popLast()
        _ = btnTitle?.characters.popFirst()
        if button.isSelected {
            button.isSelected = false
            if let indexToDelete = self.dietList.index(of: btnTitle!) {
                self.dietList.remove(at: indexToDelete)
            }
        } else {
            button.isSelected = true
            self.dietList.append(btnTitle!)
        }
    }
    
    func allergyButtonTapped(_ button: UIButton) {
        var btnTitle = button.title(for: .selected)
        _ = btnTitle?.characters.popLast()
        _ = btnTitle?.characters.popFirst()
        if button.isSelected {
            button.isSelected = false
            if let indexToDelete = self.allergyList.index(of: btnTitle!) {
                self.allergyList.remove(at: indexToDelete)
            }
        } else {
            button.isSelected = true
            self.allergyList.append(btnTitle!)
        }
    }
    
    func saveButtonTapped() {
        if !self.dietList.isEmpty{
            store.updateDiet(with: self.dietList)
        }
        if !self.allergyList.isEmpty{
            store.updateAllergy(with: self.allergyList)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func selectButtons() {
//        let allFoodButtons = [addDietView.pescetarian, addDietView.veg, addDietView.vegan, addDietView.paleo, addDietView.dairy, addDietView.egg, addDietView.gluten, addDietView.peanut, addDietView.sesame, addDietView.seafood, addDietView.shellfish, addDietView.soy, addDietView.sulfite, addDietView.treeNut, addDietView.wheat]
        
//        for button in allFoodButtons {
//            var btnSelected = false
//            var btnTitle = button?.title(for: .selected)
//            _ = btnTitle?.characters.popLast()
//            _ = btnTitle?.characters.popFirst()
//            if let btnTitle = btnTitle {
//                if store.user.allergyList.contains(btnTitle) || store.user.dietList.contains(btnTitle) {
//                    btnSelected = true
//                } else {
//                    btnSelected = false
//                }
//            } else {
//                btnSelected = false
//            }
//            if btnSelected {
//                button?.isSelected = true
//            }
//        }
    }
    
    // MARK: - UI
    
    func createUI() {
        let spacing = CGFloat(8)
        let cellWidth = self.view.bounds.width - CGFloat(2 * spacing)
        let cellHeight = CGFloat(55)
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        
        let layout: UICollectionViewFlowLayout = {
            let cvfl = UICollectionViewFlowLayout()
            cvfl.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            cvfl.itemSize = cellSize
            cvfl.minimumLineSpacing = spacing
            return cvfl
        }()
        
        self.dietsCollectionView = {
            let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            cv.dataSource = self
            cv.delegate = self
            cv.register(SettingsCell.self, forCellWithReuseIdentifier: "settingsCell")
            cv.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            return cv
        }()
        
        self.view.addSubview(self.dietsCollectionView)
        self.dietsCollectionView.snapToSuperview()
    }

}
