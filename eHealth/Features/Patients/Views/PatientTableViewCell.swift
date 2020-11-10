//
//  EpisodeTableViewCell.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.
/*
 - Each item in the list should include:
     - Image
     - Season number
     - Episode number
     - Title
     - Favorite button
 */
//

import Foundation
import UIKit

public final class PatientTableViewCell: UITableViewCell {

    private let card = UIView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let birthdayLabel = UILabel()
    private let genderLabel = UILabel()
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ model: PatientModel) {
        nameLabel.text = model.name
        birthdayLabel.text = model.birthday
        genderLabel.text = model.gender
        
        profileImageView.image = UIImage.init(named: "profile_image")
        
    }
    private func setup() {
        addSubviews()
        setupStyles()
        setupLayouts()
    }
    
    private func addSubviews() {
        addSubview(card)
        card.addSubview(profileImageView)
        card.addSubview(nameLabel)
        card.addSubview(birthdayLabel)
        card.addSubview(genderLabel)
    }
    
    private func setupStyles() {
        
        Style.for(UIView.self)
            .backgroundColor(.clear)
            .apply(on: self)
        
        Style.for(UIView.self)
            .isUserInteractionEnabled(false)
            .apply(on: self.contentView)
        
        Style.for(UIView.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .backgroundColor(UIColor(red: 0.12, green: 0.16, blue: 0.20, alpha: 1.00))
            .clipsToBounds(true)
            .cornerRadius(20)
            .apply(on: card)
        
        Style.for(UIImageView.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .contentMode(.scaleAspectFit)
            .clipsToBounds(true)
            .backgroundColor(.lightGray)
            .apply(on: profileImageView)
        
        
        Style.for(UILabel.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .font(UIFont.boldSystemFont(ofSize: 17))
            .textColor(.white)
            .apply(on: nameLabel)
        
        
        Style.for(UILabel.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .font(UIFont.boldSystemFont(ofSize: 13))
            .textColor(.white)
            .apply(on: birthdayLabel)
        
        
        Style.for(UILabel.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .font(UIFont.boldSystemFont(ofSize: 13))
            .textColor(.white)
            .apply(on:genderLabel)
        
        self.selectionStyle = .none
    }
    
    private func setupLayouts() {
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            card.topAnchor.constraint(equalTo: topAnchor, constant: padding/2),
            card.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding/2),
            card.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding*2),
            card.heightAnchor.constraint(equalToConstant: 100),
            
            profileImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: card.topAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 150),
            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: padding/2),
            nameLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: padding/2),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            birthdayLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding/2),
            birthdayLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: padding/2),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 20),
            
            genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: padding/2),
            genderLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: padding/2),
            genderLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
}
