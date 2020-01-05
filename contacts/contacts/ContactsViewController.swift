//
//  ContactsViewController.swift
//  contacts
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    
    private let avatarViewController = AvatarViewController()
    private let introViewController = IntroViewController()
    private let contactsService = ContactsService()
    
    private let progressSynchronizer = ProgressSynchronizer()
    
    private let indicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Avatar + Intro
        self.configModules()
        // Observers
        self.configObservers()
        // Network request
        self.fetchContact()
        // Placeholder
        self.configurePlaceholder()
        // IndicatorView
        self.configureIndicatiorView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.indicatorView.stopAnimating()
    }
    
    private func configModules() -> Void {
        self.configAvatars()
        self.configIntros()
    }
    
    private func configAvatars() -> Void {
        addChild(self.avatarViewController)
        view.addSubview(self.avatarViewController.view)
        self.avatarViewController.view.pin(height: 120)
        self.avatarViewController.view.pin(top: 0, leading: 0, trailing: 0)
        self.avatarViewController.didMove(toParent: self)
        self.avatarViewController.delegate = self.progressSynchronizer
    }
    
    private func configIntros() -> Void {
        addChild(self.introViewController)
        self.view.addSubview(self.introViewController.view)
        self.introViewController.view.pin(top: self.avatarViewController.view.bottomAnchor,
                                          leading: view.leadingAnchor,
                                          bottom: view.bottomAnchor,
                                          trailing: view.trailingAnchor)
        self.introViewController.didMove(toParent: self)
        self.introViewController.delegate = self.progressSynchronizer
    }
    
    private func configObservers() -> Void {
        self.progressSynchronizer.addObserver(observer: self.avatarViewController)
        self.progressSynchronizer.addObserver(observer: self.introViewController)
    }
    
    private func configurePlaceholder() -> Void {
        // Disable the scrolling when displaying placeholders
        self.updateScrollViewEnabled(flag: false)
        let contacts = contactsService.fetchContactsPlaceholder()
        self.configureWithContacs(contacts: contacts)
    }
    
    private func configureIndicatiorView() -> Void {
        view.addSubview(self.indicatorView)
        self.indicatorView.pinToSuperviewCenter()
        self.indicatorView.hidesWhenStopped = true
    }
    
    private func fetchContact() {
        self.indicatorView.startAnimating()
        contactsService.fetchContacts(param: nil) { (fetchResult) in
            self.indicatorView.stopAnimating()
            switch fetchResult {
            case .success(let contacts):
                // Disable the scrolling
                self.updateScrollViewEnabled(flag: true)
                self.configureWithContacs(contacts: contacts)

            case .failure:
                // Show error message
                print("failed...")
            }
        }
    }
    
    private func configureWithContacs(contacts: [Contact]) -> Void {
        let avatars = contacts.map { (contact) -> AvatarViewModel in
            return AvatarViewModel.init(contact: contact)
        }
        self.avatarViewController.configureAvatars(avatars: avatars)

        let intros = contacts.map { (contact) -> IntroViewModel in
            return IntroViewModel.init(contact: contact)
        }
        self.introViewController.configureIntros(intros: intros)
    }
    
    private func updateScrollViewEnabled(flag: Bool) -> Void {
        self.avatarViewController.collectionView.isScrollEnabled = flag
        self.introViewController.collectionView.isScrollEnabled = flag
    }
}
