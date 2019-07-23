//
//  FavoritesTableViewCell.m
//  Приложение для кондитера
//
//  Created by Константин on 23.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "catalog-app/ApplicationData.h"
#import "FavoritesTableViewCell.h"

@implementation FavoritesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)addToCartFormFavorites:(id)sender {
    [ApplicationData addToCart:p];
        [sender setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
}

- (void) setProduct:(Product*)v{
    p = v;
    _titleImg.image = p.previewImg;
    [_name setText:p.name];
    [_price setText:[NSString stringWithFormat:@"%@ ₽",p.price]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
