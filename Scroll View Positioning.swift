//
//  Scroll View Positioning.swift
//  
//
//  Created by Dan Lages on 16/09/2018.
//

import Foundation
import UIKit


//This code is usefull if keyboard covers text field, offering greater User Experiance

//Notify when keyboard/picker is present -- TO BE PLACED IN VIEW DID LOAD OR RELATIVE FUNCTION
NotificationCenter.default.addObserver(self, selector: #selector(self.userInputPresent), name: NSNotification.Name.UIKeyboardDidShow, object: nil) //Show Notification
NotificationCenter.default.addObserver(self, selector: #selector(self.userInputEnded), name: NSNotification.Name.UIKeyboardWillHide, object: nil) //Hide Notification



//MARK: Scroll View Positioning

@objc func userInputPresent(notification: NSNotification) {
    var currentStatus = notification.userInfo
    let insetSize = currentStatus![UIKeyboardFrameEndUserInfoKey] as! CGRect //Set inset size to size of Keyboard/Picker
    scrollView.contentInset = UIEdgeInsetsMake(0.0, 00, insetSize.height, 0.0) //Move Scroll view up to desired inset size
    placeOrderScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 00, insetSize.height, 0.0)
}

@objc func userInputEnded(notification: NSNotification) {
    scrollView.contentInset = UIEdgeInsets.zero //Revert Scroll View to previous position
    scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
}


