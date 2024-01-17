//
//  Animation.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 11.01.2024.
//

import Foundation
import UIKit
import Lottie

class Animation {
    static var animationSpeed = 2.0
    static let animationTag = 100
    
    static func showActivityIndicator(animationName : String = "loading") {
         DispatchQueue.main.async {
             let mainVw = UIView()
             mainVw.backgroundColor = .black
             let lottieView = LottieAnimationView(name: animationName)
             lottieView.loopMode = .loop
             lottieView.animationSpeed = Animation.animationSpeed
             lottieView.play()
             lottieView.backgroundColor = .clear
             mainVw.backgroundColor = .clear
             mainVw.tag = Animation.animationTag
             if let  window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
                mainVw.frame = CGRect(x: 0, y: 0, width: ((window.rootViewController?.view.frame.width)!), height:(window.rootViewController?.view.frame.height)!)
                lottieView.frame = CGRect(x: (mainVw.frame.width)/2-50 , y: (mainVw.frame.height)/2-50, width: 100, height: 100)
                mainVw.addSubview(lottieView)
                window.rootViewController!.view.addSubview(mainVw)
             }
         }
     }

    static func hideActivityIndicator()  {
          var theSubviews = [UIView]()
          if let  window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
             theSubviews = (window.rootViewController?.view.subviews)!
          }
          for subview in theSubviews {
              if subview.tag == Animation.animationTag {
                  subview.removeFromSuperview()
              }
          }
      }
}
