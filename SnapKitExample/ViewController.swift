//
//  ViewController.swift
//  SnapKitExample
//
//  Created by AnatoliiOstapenko on 24.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
        
    private let padding: CGFloat = 12
    private var isIPad: Bool = false
    
    // MARK: - View Properties
    
    private lazy var backButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = isIPad ? Constants.back : ""
        configuration.image = Constants.backImage
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
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var newAddButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = isIPad ? Constants.add : ""
        configuration.image = Constants.addImage
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
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Left title label"
        label.backgroundColor = .systemCyan
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right title label"
        label.backgroundColor = .systemPink
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let container = UIView()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        mainLabel.text = Constants.initialText
        isIPad = UIDevice.current.userInterfaceIdiom == .pad ? true : false
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
        view.addAllSubbviews(backButton, segment, newAddButton, mainLabel, container)
        container.addAllSubbviews(leftLabel, rightLabel)
        container.backgroundColor = .clear
        
        /// Container for left and right labels
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }

        /// Back button
        backButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(padding)
        }
        
        /// Segmented switch
        segment.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        segment.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-padding)
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(backButton.snp.height)
        }
        
        /// New add button
        newAddButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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

extension ViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        container.snp.updateConstraints { make in
            make.leading.equalTo(isPortrait ? 0 : 50)
            make.trailing.equalTo(isPortrait ? 0 : -50)
        }
        
    }
}

private extension UIView {
    func addAllSubbviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

private enum Constants {
    static let initialText = "Toggle right switch"
    static let back = "Back to Profile"
    static let backImage = UIImage(systemName: "arrowshape.backward")
    static let add = "Add new item"
    static let addImage = UIImage(systemName: "plus.circle")
    static let short = "Short text"
    static let wide = "If you set a segmented control to have a momentary style, a segment doesn’t show itself as selected (blue background) when the user touches it. The disclosure button is always momentary and doesn’t affect the actual selection."
}

