//
//  UIUtil.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/04/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices
import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

///
/// Alert with the passed message, with single OK button to dismiss the alert.
///
internal func alertWithMessage(sender: UIViewController, title: String) {
	let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert);
	let dismissAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil);
	alertController.addAction(dismissAction);
	sender.presentViewController(alertController, animated: true, completion: nil);
}

///
/// Alert with two actions, pass the handlers for each action and the titles for each.
///
internal func binaryChoiceMessage(sender: UIViewController, title: String,
	choice0: String, handler0: ((UIAlertAction) -> Void)?,
	choice1: String, handler1: ((UIAlertAction) -> Void)?) {

		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert);
		let action0 = UIAlertAction(title: choice0, style: .Default, handler: handler0);
		let action1 = UIAlertAction(title: choice1, style: .Default, handler: handler1);
		alertController.addAction(action0);
		alertController.addAction(action1);
		sender.presentViewController(alertController, animated: true, completion: nil);
}

///
/// Check it the passed media is available using the image picker view controller.
/// e.g. Check for .Camera, .PhotoLibrary
///
internal func imagePickerMediaAvailable(sourceType: UIImagePickerControllerSourceType) -> Bool {
	if let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
	where UIImagePickerController.isSourceTypeAvailable(sourceType)
	&& mediaTypes.contains(kUTTypeImage as String) {
		return true;
	} else {
		return false;
	}
}

///
/// Dispatch a thread to navigate to the settings of this app
///
internal func goToSettings() {
	dispatch_async(dispatch_get_main_queue(), {
		UIApplication.sharedApplication().openURL(
			NSURL(string: UIApplicationOpenSettingsURLString)!);
	})
}
