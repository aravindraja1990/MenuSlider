//
//  SliderNavigationProtocol.swift
//  MenuSlider
//
//  Created by aravind raja on 8/26/16.
//  Copyright © 2016 aravind raja. All rights reserved.
//

import UIKit

enum MenuState {
    case leftMenu
    case rightMenu
    case collapsed
}

protocol SliderNavigationProtocol {
    func toggleLeftMenu (sender:AnyObject,userInfo:[String:AnyObject]?)
}
