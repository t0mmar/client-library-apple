//
//  SignupSuccessViewController.swift
//  PIALibrary-iOS
//
//  Created by Davide De Rosa on 10/8/17.
//  Copyright © 2017 London Trust Media. All rights reserved.
//

import Foundation
import SwiftyBeaver

private let log = SwiftyBeaver.self

public class SignupSuccessViewController: AutolayoutViewController, BrandableNavigationBar {

    @IBOutlet private weak var imvPicture: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelMessage: UILabel!
    @IBOutlet private weak var labelUsernameCaption: UILabel!
    @IBOutlet private weak var labelUsername: UILabel!
    @IBOutlet private weak var labelPasswordCaption: UILabel!
    @IBOutlet private weak var labelPassword: UILabel!
    @IBOutlet private weak var buttonSubmit: PIAButton!
    @IBOutlet private weak var usernameContainer: UIView!
    @IBOutlet private weak var passwordContainer: UIView!

    @IBOutlet private weak var constraintPictureXOffset: NSLayoutConstraint!
    
    var metadata: SignupMetadata?
    
    weak var completionDelegate: WelcomeCompletionDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        guard let metadata = metadata else {
            fatalError("Metadata not set")
        }

        title = metadata.title
        imvPicture.image = metadata.bodyImage
        if let offset = metadata.bodyImageOffset {
            constraintPictureXOffset.constant = offset.x
        }
        labelTitle.text = metadata.bodyTitle
        labelMessage.text = metadata.bodySubtitle

        navigationItem.hidesBackButton = true

        labelUsernameCaption.text = L10n.Signup.Success.Username.caption
        labelUsername.text = metadata.user?.credentials.username
        labelPasswordCaption.text = L10n.Signup.Success.Password.caption
        labelPassword.text = metadata.user?.credentials.password

        self.styleSubmitButton()
        self.styleContainers()
    }
    
    @IBAction private func submit() {
        guard let user = metadata?.user else {
            fatalError("User account not set in metadata")
        }
        completionDelegate?.welcomeDidSignup(withUser: user, topViewController: self)
    }

    // MARK: Restylable

    override public func viewShouldRestyle() {
        super.viewShouldRestyle()
        navigationItem.titleView = NavigationLogoView()
        Theme.current.applyNavigationBarStyle(to: self)
        Theme.current.applyLightBackground(view)
        Theme.current.applyLightBackground(viewContainer!)

        Theme.current.applyTitle(labelTitle, appearance: .dark)
        Theme.current.applySubtitle(labelMessage)

        Theme.current.applySubtitle(labelUsernameCaption)
        Theme.current.applyTitle(labelUsername, appearance: .dark)
        Theme.current.applySubtitle(labelPasswordCaption)
        Theme.current.applyTitle(labelPassword, appearance: .dark)
    }
    
    private func styleSubmitButton() {
        buttonSubmit.setRounded()
        buttonSubmit.style(style: TextStyle.Buttons.piaGreenButton)
        buttonSubmit.setTitle(L10n.Signup.Success.submit.uppercased(),
                              for: [])
    }
    
    private func styleContainers() {
        self.styleContainerView(usernameContainer)
        self.styleContainerView(passwordContainer)
    }
    
    func styleContainerView(_ view: UIView) {
        view.layer.cornerRadius = 6.0
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.piaGrey4.cgColor
    }

}
