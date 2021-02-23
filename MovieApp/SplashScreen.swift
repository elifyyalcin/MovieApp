//
//  ViewController.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit
import Lottie

class SplashScreen: UIViewController {

    let animation =  Animation.named("splash")
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.frame = CGRect(x:125, y:300, width: 175, height: 175)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        Timer.scheduledTimer(withTimeInterval: 7.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "homePage", sender: nil)
        }
    }


}

