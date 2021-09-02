//
//  VideoCell.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 24.08.2021.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    var cellColor: UIColor?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 108/255, green: 70/255, blue: 47/255, alpha: 255/255)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size.width = contentView.frame.size.width - 16
        view.layer.cornerRadius = 4
        return view
    }()

    var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textAlignment = .left
        return label
    }()
    
    var videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.defaultBackgroundColor
        selectionStyle = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with video: VideoInfo) {
       // print(contentView.frame.size.width)
        print(contentView.frame.size.width)
        contentView.addSubview(containerView)
        configureContainerView()
        let thumbnailURL = URL(string: video.nImage.value)
        videoImageView.kf.setImage(with: thumbnailURL)
        videoTitleLabel.text = video.title
        containerView.backgroundColor = hexStringToUIColor(hex: video.colorAvarage)
        videoTitleLabel.textColor = hexStringToUIColor(hex: video.textColor)
    }
    
    
    func configureContainerView() {
        containerView.addSubview(videoImageView)
        containerView.addSubview(videoTitleLabel)
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        videoImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        videoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        videoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        videoImageView.widthAnchor.constraint(equalToConstant: containerView.bounds.width/2).isActive = true
        
        videoTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 8).isActive = true
        videoTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        videoTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        videoTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
    }

}

