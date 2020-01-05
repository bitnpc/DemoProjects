//
//  IntroViewController.swift
//  contacts
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProgressUpdateProtocol {
    
    public weak var delegate: ProgressSyncDelegate?
    
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var introViewModels: [IntroViewModel]?
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        self.setupUI()
    }

    func setupUI() -> Void {
        view.addSubview(self.collectionView)
        self.collectionView.pinToSuperview()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(IntroCell.self, forCellWithReuseIdentifier: IntroCell.reuseIdentifier())
        self.collectionView.isPagingEnabled = true
        self.collectionView.backgroundColor = .white
        
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0;
    }
    
    func configureIntros(intros: [IntroViewModel]) -> Void {
        self.introViewModels = intros
        self.collectionView.reloadData()
    }
    
    // MARK: ===== UICollectionViewDataSource =====
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let intros = self.introViewModels else {
            return 0
        }
        return intros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroCell.reuseIdentifier(), for: indexPath)
        guard let intros = self.introViewModels else {
            return cell
        }
        if let introCell = cell as? IntroCell {
            introCell.configure(with: intros[indexPath.row])
        }
        return cell
    }
    
    // MARK: ===== UICollectionViewDelegateFlowLayout =====
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    // MARK: ===== UIScrollViewDelegate =====
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.y / view.frame.height
        delegate?.didUpdate(subject: self, progress: Double(progress))
    }
    
    // MARK: ===== ProgressUpdateProtocol =====
    
    func update(_ progress: Double) {
        collectionView.contentOffset.y = CGFloat(progress) * collectionView.frame.size.height
    }
}
