//
//  JediTableViewCell.m
//  StarWarsCells
//
//  Created by Donny Davis on 5/4/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "JediTableViewCell.h"

@implementation JediTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor colorWithRed:(234/255.0) green:(232/255.0) blue:(93/255.0) alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(Character *)character {
    self.nameLabel.text = character.name;
    self.descriptionLabel.text = character.shortDescription;
    self.profileImage.image = [UIImage imageNamed:character.image];
}

@end
