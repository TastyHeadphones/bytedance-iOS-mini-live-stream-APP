//
//  GiftViewController.swift
//  live-stream-APP
//
//  Created by Magic Keegan on 12/28/21.
//

import UIKit
import SpriteKit
class GiftViewController: UIViewController {
    var giftTableView:UITableView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        giftTableView.dataSource = self
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendGift(_ button:UIButton){
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0.5,options: [.allowUserInteraction],
                       animations: {
            button.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }, completion:nil)
        
        let point = button.superview!.convert(button.center, to: nil)
        print(point)
        let image = UIImage(systemName:"gift.fill")?.withTintColor(UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        ),renderingMode: .alwaysOriginal)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.image = image
        imageView.center = point
        
        let leftOrRight = arc4random() % 2
        imageView.transform = imageView.transform.rotated(by: .pi / 9.0 * Double(leftOrRight))
        
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 2) {
            imageView.frame.origin.y = -100
            imageView.alpha = 0.0
        } completion: { finished in
            imageView.removeFromSuperview()
        }
    }
    
    @IBAction func sendGifts(_ button:UIButton){
        if let spark = SKEmitterNode(fileNamed: "Spark") {
            let skView = SKView(frame: view.frame)
            skView.backgroundColor = .clear
            let scene = SKScene(size: view.frame.size)
            scene.backgroundColor = .clear
            skView.presentScene(scene)
            skView.isUserInteractionEnabled = false
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.addChild(spark)
            spark.position.y = scene.frame.maxY
            spark.particlePositionRange.dx = scene.frame.width
            view.addSubview(skView)
            
            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                skView.removeFromSuperview()
            }
            
        }
    }
    
    
    @IBAction func dismissVC(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }

}

//extension GiftViewController:UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return nil
//    }
//
//
//}
