//
//  DateDownloadCell.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 30.08.2021.
//

import UIKit

protocol DateDownloadCellDelegate: AnyObject {
    func handleDownloadButtonTapped()
}

protocol DownloadSettingsDelegate: AnyObject {
    func settingsButtonTapped()
}

class DateDownloadCell: UITableViewCell {

    weak var delegate: DateDownloadCellDelegate?
    weak var settingsDelegate: DownloadSettingsDelegate?
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "geçen ay"
        return label
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(systemName: "arrow.down.to.line")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false

        button.addTarget(self, action: #selector(handleDownload), for: .touchUpInside)
        return button
    }()
    
    var categoryContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 121/255, blue: 41/255, alpha: 1)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "Cep Telefonları"
        return label
    }()
    
//    var percentageLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = false
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textAlignment = .center
//        return label
//    }()
    
    lazy var percentageLabel: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false

        button.addTarget(self, action: #selector(handleSettingsTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(categoryContainerView)
        contentView.addSubview(percentageLabel)
        categoryContainerView.addSubview(categoryLabel)
        
        
        categoryContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        categoryContainerView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        categoryLabel.centerYAnchor.constraint(equalTo: categoryContainerView.centerYAnchor).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: categoryContainerView.centerXAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: categoryContainerView.leadingAnchor, constant: 8).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: categoryContainerView.trailingAnchor, constant: -8).isActive = true
        
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: categoryContainerView.trailingAnchor, constant: 12).isActive = true
        
        downloadButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        downloadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        percentageLabel.trailingAnchor.constraint(equalTo: downloadButton.leadingAnchor, constant: -10).isActive = true
        //percentageLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //percentageLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    @objc func handleDownload() {
        delegate?.handleDownloadButtonTapped()
    }
    
    @objc func handleSettingsTapped() {
        settingsDelegate?.settingsButtonTapped()
    }

}

