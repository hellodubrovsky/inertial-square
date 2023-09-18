//
//  ViewController.swift
//  inertial-square
//
//  Created by Илья on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var animator: UIDynamicAnimator!
    private var dynamicItem: UIDynamicItemBehavior!
    private var collision: UICollisionBehavior!
    private var snap: UISnapBehavior!
    
    private lazy var squareView: UIView = {
        let frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100)
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(squareView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animator = UIDynamicAnimator(referenceView: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animator.removeAllBehaviors()
        touches.forEach { [weak self] touch in
            guard let self else { return }
            
            dynamicItem = UIDynamicItemBehavior(items: [squareView])
            dynamicItem.resistance = 40
            
            collision = UICollisionBehavior(items: [squareView])
            collision.translatesReferenceBoundsIntoBoundary = true
            
            let location = touch.location(in: self.view)
            snap = UISnapBehavior(item: self.squareView, snapTo: location)
            snap.damping = 0.3
            
            animator.addBehavior(snap)
            animator.addBehavior(dynamicItem)
            animator.addBehavior(collision)
        }
    }
}

