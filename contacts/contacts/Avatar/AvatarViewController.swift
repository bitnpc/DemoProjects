//
//  AvatarViewController.swift
//  contacts
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

private struct Const {
    static let velocityCoefficient: CGFloat = 100.0
    static let percentageThreshold: CGFloat = 0.7
}

class AvatarViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProgressUpdateProtocol {
    
    public weak var delegate: ProgressSyncDelegate?
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var avatarViewModels: [AvatarViewModel]?
    private lazy var offset = (view.frame.width - AvatarViewModel.cellSize.width) / 2

    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset)
    }

    func setupUI() -> Void {
        view.addSubview(self.collectionView)
        self.collectionView.pinToSuperview()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseIdentifier())
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = .white
        
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = AvatarViewModel.cellSize
    }
    
    func configureAvatars(avatars: [AvatarViewModel]) -> Void {
        self.avatarViewModels = avatars
        self.collectionView.reloadData()
    }
    
    // MARK: ===== UICollectionViewDataSource =====
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let avatars = self.avatarViewModels else {
            return 0
        }
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.reuseIdentifier(), for: indexPath)
        guard let avatars = self.avatarViewModels else {
            return cell
        }
        if let avatarCell = cell as? AvatarCell {
            avatarCell.configure(with: avatars[indexPath.row])
        }
        return cell
    }
    
    // MARK: ===== UICollectionViewDelegate =====

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let centerIndexPath = collectionView.centerIndexPath,
            indexPath.row != centerIndexPath.row else {
                return
        }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: ===== ProgressUpdateProtocol =====
    func update(_ progress: Double) {
        collectionView.contentOffset.x = CGFloat(progress) * AvatarViewModel.cellSize.width - offset
    }
    
    // MARK: ===== ScrollViewDelegate =====
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = (scrollView.contentOffset.x + offset) / AvatarViewModel.cellSize.width
        delegate?.didUpdate(subject: self, progress: Double(progress))
    }
    private var currentPage: CGFloat = 0
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidth = AvatarViewModel.cellSize.width
        // Expected contentOffset with velocity
        let targetOffset = scrollView.contentOffset.x + scrollView.contentInset.left + velocity.x * Const.velocityCoefficient
        
        var targetPage = targetOffset / cellWidth
        // Culculate target page
        if floor(targetPage + Const.percentageThreshold) == floor(targetPage) {
            targetPage = floor(targetPage)
        }else {
            targetPage = floor(targetPage + 1)
        }
        let targetOffsetX = cellWidth * targetPage
        // Update pointee
        targetContentOffset.pointee = CGPoint(x: targetOffsetX - collectionView.contentInset.left, y: targetContentOffset.pointee.y)
    }
}
