//
//  MediaVC.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 27/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MobileCoreServices

class ImagesPopoverVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MediaContainer {

/// Image stuff
    private var picker: MediaPicker?;
    var mediaCountDelegate: MediaCountDelegate?; /// when the count of images changes
    private var images: [UIImage]?; /// The images shown in the image view
    private var imageIndex = 0; /// Which image showing currently

    @IBOutlet weak var imageIndexLabel: UILabel!
    @IBOutlet weak var navigationViews: UIView!
    @IBOutlet weak var currentlyShownImage: UIImageView!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBAction func onCameraButtonPressed(sender: AnyObject) { picker?.pickUsingCamera(); }
    @IBAction func onPhotosLibraryButtonPressed(sender: AnyObject) { picker?.pickFromLibrary(); }

    @IBAction func onPreviousButtonPressed(sender: AnyObject) {
        if let images = images where images.count > 1 {
            imageIndex = imageIndex - 1 < 0 ? images.count - 1: imageIndex - 1;
            imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
            setCurrentImage();
    } }

    @IBAction func onNextButtonPressed(sender: AnyObject) {
        if let images = images where images.count > 1 {
            imageIndex = imageIndex + 1 < images.count ? imageIndex + 1: 0;
            imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
            setCurrentImage();
    } }
    @IBAction func onDeleteButtonPressed(sender: AnyObject) {
        onDelete();
    }

///
/// Load any temp images, and show the first
///
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        dispatch_async(dispatch_get_main_queue(), {
            self.picker = MediaPicker(parentVC: self, mediaType: kUTTypeImage as String)
            self.loadTempImages();
            self.setCurrentImage();
        });
    }

///
/// If we have images in the images array, set the one at position image index to our image view
/// else hide the image view, along with the controls assosicated with it
///
    private func setCurrentImage() {
        if let images = images where images.count > imageIndex && 0 <= imageIndex {
            currentlyShownImage.image = images[imageIndex];
            noImageLabel.hidden = true;
            navigationViews.hidden = false;
            imageIndexLabel.hidden = false;
            imageIndexLabel.text = "\(imageIndex + 1) / \(images.count) "
        } else {
            currentlyShownImage.image = nil;
            noImageLabel.hidden = false;
            navigationViews.hidden = true;
            imageIndexLabel.hidden = true;
        }
    }
///
/// Load any temp images
///
    func loadTempImages() {
        if images == nil {
            images = DataManager.getManagerInstance().getTempImages();
        }
    }

    func onDelete() {
        if let images = self.images where images.count > imageIndex {
            let controller = UIAlertController(title: deleteTheImageText,
                message: nil, preferredStyle: .ActionSheet)

            let yesAction = UIAlertAction(title: yes, style: .Destructive, handler: {
                action in
                self.images!.removeAtIndex(self.imageIndex);
                DataManager.getManagerInstance().removeTempImage(self.imageIndex);
                self.mediaCountDelegate?.onCountChange(self);
                self.imageIndex = max(0, self.imageIndex - 1);
                self.setCurrentImage();
            });
            controller.addAction(yesAction)
            controller.addAction(UIAlertAction(title: no, style: .Cancel, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    func onNewImage(image: UIImage) {
        if images == nil {
            images = Array<UIImage>();
            imageIndex = 0 ;
        }
        images!.append(image);
        imageIndex = images!.count - 1;
        DataManager.getManagerInstance().saveTempImage(image);
        mediaCountDelegate?.onCountChange(self);
        setCurrentImage();
    }
}
