//
//  ViewController.swift
//  SnapKitExample
//
//  Created by AnatoliiOstapenko on 24.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - View Properties
    private let padding: CGFloat = 12
    
    private lazy var backButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Back to Profile"
        configuration.image = UIImage(systemName: "arrowshape.backward")
        configuration.imagePadding = 4
        
        configuration.baseBackgroundColor = .systemCyan
        configuration.baseForegroundColor = .systemCyan

        let button = UIButton(configuration: configuration, primaryAction: UIAction { _ in
            self.mainLabel.text = ""
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newAddButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Add new item"
        configuration.image = UIImage(systemName: "plus.circle")
        configuration.imagePadding = 4
        
        configuration.baseBackgroundColor = .systemRed
        configuration.baseForegroundColor = .systemRed

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["◀︎", "▶︎"])
        segment.addTarget(self, action: #selector(segmentTap), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        mainLabel.text = "Toggle right switch"
    }
    
    // MARK: - Methods
    
    @objc private func backButtonTap() {
        print("tap tap")
    }
    
    @objc private func segmentTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: mainLabel.text = Constants.short
        case 1: mainLabel.text = Constants.wide
        default: break
        }
    }
    
    private func updateUI() {
        view.backgroundColor = .systemBackground
        view.addAllSubbviews(backButton, segment, newAddButton, mainLabel)

        /// Back button
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(padding)
        }
        
        /// Segmented switch
        segment.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        segment.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(backButton.snp.height)
        }
        
        /// New add button
        newAddButton.snp.makeConstraints { make in
            make.trailing.equalTo(segment.snp.leading).offset(-padding)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        /// Main label
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(padding)
            make.trailing.equalTo(newAddButton.snp.leading).offset(-padding)
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(backButton.snp.height)
        }
    }
    
    
}

private extension UIView {
    func addAllSubbviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

private enum Constants {
    static let short = "Short text"
    static let wide = "If you set a segmented control to have a momentary style, a segment doesn’t show itself as selected (blue background) when the user touches it. The disclosure button is always momentary and doesn’t affect the actual selection."
}
