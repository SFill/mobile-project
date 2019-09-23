//
//  FavoritesTableViewCell.m
//  Приложение для кондитера
//
//  Created by Константин on 23.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "catalog-app/ApplicationData.h"
#import "FavoritesTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@implementation FavoritesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(cartWasChanged:)
                                             name:@"cartWasChanged"
                                           object:nil];
}
-(void)cartWasChanged:(NSNotification *) notification{
    Product* searchedProduct = [ApplicationData searchCart:p];
    
    if(searchedProduct ==nil){
        [self.cartButton setImage:[UIImage imageNamed:@"cartonlyone.jpg"] forState:UIControlStateNormal];
        
    }else{
        [self.cartButton setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)addToCartFormFavorites:(id)sender {
    [ApplicationData addToCart:p];
    [sender setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
    
    
}

- (void) setProduct:(Product*)v{
    p = v;
   // _titleImg.image = p.previewImg;
    [self.titleImg sd_setImageWithURL:[NSURL URLWithString:p.previewImgStringURL]
     placeholderImage:[UIImage imageNamed:@"iconkulinar.png"]
     ];
    [_name setText:p.name];
    [_price setText:[NSString stringWithFormat:@"%@ ₽",p.price]];
    Product* searchedProduct = [ApplicationData searchCart:p];
    
    if(searchedProduct ==nil){
        [self.cartButton setImage:[UIImage imageNamed:@"cartonlyone.jpg"] forState:UIControlStateNormal];
        
    }else{
        [self.cartButton setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
