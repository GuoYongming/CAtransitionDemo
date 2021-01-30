//
//  ViewController.swift
//  CAtransitionDemo
//
//  Created by GuoYongming on 2021/1/29.
//

import UIKit

enum Type {
    case fade
    case moveIn
    case push
    case reveal
    case cube
    case suckEffect
    case oglFlip
    case rippleEffect
    case pageCurl
    case pageUnCurl
    case cameraIrisHollowOpen
    case cameraIrisHollowClose
    
    var value: CATransitionType {
        switch self {
        case .fade:
            return .fade
        case .moveIn:
            return .moveIn
        case .push:
            return .push
        case .reveal:
            return .reveal
        case .cube:
            return CATransitionType(rawValue: "cube")
        case .suckEffect:
            return CATransitionType(rawValue: "suckEffect")
        case .oglFlip:
            return CATransitionType(rawValue: "oglFlip")
        case .rippleEffect:
            return CATransitionType(rawValue: "rippleEffect")
        case .pageCurl:
            return CATransitionType(rawValue: "pageCurl")
        case .pageUnCurl:
            return CATransitionType(rawValue: "pageUnCurl")
        case .cameraIrisHollowOpen:
            return CATransitionType(rawValue: "cameraIrisHollowOpen")
        case .cameraIrisHollowClose:
            return CATransitionType(rawValue: "cameraIrisHollowClose")
        }
    }
    
    var text: String {
        switch self {
        case .fade:
            return "fade"
        case .moveIn:
            return "moveIn"
        case .push:
            return "push"
        case .reveal:
            return "reveal"
        case .cube:
            return "cube"
        case .suckEffect:
            return "suckEffect"
        case .oglFlip:
            return "oglFlip"
        case .rippleEffect:
            return "rippleEffect"
        case .pageCurl:
            return "pageCurl"
        case .pageUnCurl:
            return "pageUnCurl"
        case .cameraIrisHollowOpen:
            return "cameraIrisHollowOpen"
        case .cameraIrisHollowClose:
            return "cameraIrisHollowClose"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textLabel: UILabel!
    
    let typeArray: Array<Type> = [.fade, .moveIn, .push, .reveal, .cube, .suckEffect, .oglFlip, .rippleEffect, .pageCurl, .pageUnCurl, .cameraIrisHollowOpen, .cameraIrisHollowClose]
    var subTypeIndex: Int = 0
    var currentType: Type = .fade

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "导航栏"
        initCollectionView()
        initTextLabel()
    }
    
    func initCollectionView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.orange
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initTextLabel() {
        textLabel.backgroundColor = UIColor.red
        textLabel.text = "Red"
    }

    func runTransition(type: Type) {
        if currentType.text != type.text {
            subTypeIndex = 0
        }
        currentType = type
        var subType: CATransitionSubtype?
        var toColor: UIColor?
        var toString: String = ""
        switch subTypeIndex {
        case 0:
            subType = .fromRight
            toColor = UIColor.blue
            toString = "Blue"
        case 1:
            subType = .fromLeft
            toColor = UIColor.purple
            toString = "Purple"
        case 2:
            subType = .fromTop
            toColor = UIColor.cyan
            toString = "Cyan"
        case 3:
            subType = .fromBottom
            toColor = UIColor.red
            toString = "Red"
        default:
            subType = .none
        }
        subTypeIndex += 1
        if subTypeIndex > 3 {
            subTypeIndex = 0
        }
        
        let transition = CATransition()
        transition.duration = 0.8
        transition.type = type.value
        transition.subtype = subType
        
        textLabel.layer.add(transition, forKey: "transition")
        textLabel.backgroundColor = toColor
        textLabel.text = toString + "\n\n" + type.text
        
        // 如果将动画添加到navigation的view上，则会进行Controller之间的切换。
//        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
//        self.navigationController?.view.layer.add(transition, forKey: "transition")
//        self.navigationController?.pushViewController(detailVC, animated: false)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let type = typeArray[indexPath.item]
        cell.textLabel.text = type.text
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width-30.0)/2, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = typeArray[indexPath.item]
        runTransition(type: type)
    }
}

