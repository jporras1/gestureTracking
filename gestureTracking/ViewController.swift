//
//  ViewController.swift
//  gestureTracking
//
//  Created by Javier Porras jr on 10/16/19.
//  Copyright © 2019 Javier Porras jr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let numCol = 15
    let numRow = 26
    var cells = [String: UIView]()
    var selectedCell: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let width = view.frame.width / CGFloat(numCol)
        
        //MARK: Random Squares generated
        for y in 0...numRow{
            for x in 0...numCol{
                let colorView = UIView()
                colorView.backgroundColor = randomColor()
                colorView.frame = CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width, height: width)
                colorView.layer.borderWidth = 0.5
                colorView.layer.borderColor = UIColor.black.cgColor //expects CGColor instead of UIColor.
                view.addSubview(colorView)
                let key = "\(x)|\(y)"
                cells[key] = colorView
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }//end of ViewDidLoad
    
    @objc  //MARK: Pan functionality.
    func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numCol)
        let col = Int(location.x / width)
        let row = Int(location.y / width)
        let key = "\(col)|\(row)"
        
        guard let cellView = cells[key] else { return }
        
        if selectedCell != cellView{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        view.bringSubviewToFront(cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    //MARK: Random color generator
    fileprivate func randomColor()->UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

