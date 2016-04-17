//
//  QuestionnaireViewController.swift
//  MySportsDiary
//
//  Created by Evdzhan Mustafa on 11/03/2016.
//  Copyright © 2016 Evdzhan Mustafa. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

	let INITAL_TEXT = "Click the bellow button to answer the initial questionnaire.";

	let DIARY_TEXT = "You've answered the questionnaire." +
		" You will answer the questionnaire again, at the end." +
		" You can now proceed to add new entries in the diary.\(InitialVC.dateToDisplay)";
	let FINAL_TEXT = "Now you must answer the final questionnaire. Click below to begin.";

	static private var dateToDisplay: String {
		get {
			if let dateString = DataManagerInstance().getDiaryStart() {
				let date = stringDate(dateString);
				return "\n\nYou will answer the diary again on \(screenDateString(date))"
			}
			return "";
		}
	}

	@IBOutlet weak var mainLabel: UILabel!;
	@IBOutlet weak var beginButton: UIButton!;
	@IBOutlet weak var sendButton: UIButton!

	@IBAction func onSendPressed(sender: AnyObject) {
	}
	override func viewDidLoad() {
		super.viewDidLoad();
		mainLabel.accessibilityIdentifier = Accessibility.MainLabel;
		beginButton.accessibilityIdentifier = Accessibility.BeginButton;
	}

	///
	/// Hide back button. If enable the second and third
	/// tab bars if we are in Diary mode, else only the first tab bar is enabled.
	///
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);

		let appState = DataManagerInstance().getAppState() ?? .Initial
		switch (appState) {
		case (.Diary):
			setForDiaryMode();
		case (.Initial):
			setForInitialMode();
		case (.Final):
			setForFinalMode();
		}
		// hide the bar above, since there is no back screen to move to,
		// and the back button is not there
		self.navigationController?.setNavigationBarHidden(true, animated: true);
	}
	///
	/// Enable the second and third tabs
	/// Hide the begin button in the first tab
	///
	private func setForDiaryMode() {
		self.tabBarController?.tabBar.items![1].enabled = true;
		self.tabBarController?.tabBar.items![2].enabled = true;
		mainLabel.text = DIARY_TEXT;
		beginButton.hidden = true;
		sendButton.hidden = false;
	}

	///
	/// Hide the second and third tabs
	/// Make the begin button visible
	///
	private func setForInitialMode() {
		self.tabBarController?.tabBar.items?[1].enabled = false;
		self.tabBarController?.tabBar.items?[2].enabled = false;
		mainLabel.text = INITAL_TEXT;
		beginButton.hidden = false;
		sendButton.hidden = true;
	}

	///
	/// Disable the second and third tabs again
	/// Show the begin button
	///
	private func setForFinalMode() {
		self.tabBarController?.tabBar.items?[1].enabled = false;
		self.tabBarController?.tabBar.items?[2].enabled = false;
		mainLabel.text = FINAL_TEXT;
		beginButton.hidden = false;
		sendButton.hidden = false;
	}

	///
	/// See if it is the first survey or final survey...
	///
	@IBAction func onSurveyBegin(sender: AnyObject) {
		let appState = DataManagerInstance().getAppState() ?? .Initial;
		if (appState == .Initial) {
			self.performSegueWithIdentifier("AgeAndGenderSegue", sender: sender);
		} else {
			self.performSegueWithIdentifier("QuestionnaireSegue", sender: sender);
		}
	}
}
