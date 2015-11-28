//
//  RappleColorPickerViewController.swift
//  Pods
//
//  Created by Rajeev Prasad on 28/11/15.
//
//

import UIKit

class RappleColorPickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView : UICollectionView!
    private var titleLabel : UILabel!
    
    var tintColor = UIColor.whiteColor()
    var bgColor = UIColor.blackColor()
    
    var delegate: RappleColorPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = bgColor
        
        self.view.layer.cornerRadius = 4.0
        self.view.layer.borderWidth = 2.0
        self.view.layer.borderColor = tintColor.CGColor
        self.view.layer.masksToBounds = true
        
        let layout = RappleColorPickerFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 30, height: 30)
        
        let colRect = CGRectMake(0, 30, 192, 322)
        collectionView = UICollectionView(frame: colRect, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = tintColor
        self.view.addSubview(collectionView)
        collectionView.reloadData()
        
        titleLabel = UILabel(frame: CGRectMake(2,2,180,28))
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = tintColor
        titleLabel.text = self.title
        self.view.addSubview(titleLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = getColor(indexPath.section, row: indexPath.row)
        cell.layer.cornerRadius = 1.0
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.layer.borderWidth = 1.0
        return cell
    }
    
    func getColor(section:Int, row:Int) -> UIColor {
        return UIColor.redColor()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.colorSelected(getColor(indexPath.section, row: indexPath.row))
    }
}

class RappleColorPickerFlowLayout : UICollectionViewFlowLayout {
    
    let cellSpacing:CGFloat = 1
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElementsInRect(rect) {
            for (index, attribute) in attributes.enumerate() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = CGRectGetMaxX(prevLayoutAttributes.frame)
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize().width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}
