//
//  TableViewCell.m
//  Приложение для кондитера
//
//  Created by User on 03/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TableViewCell.h"
#import "catalog-app/ApplicationData.h"

@implementation TableViewCell

//- (IBAction)addToFavorites:(id)sender {
    //[ApplicationData addToFavorites:p];
    //[sender setImage:[UIImage imageNamed:@"wishes life1.jpg"] forState:UIControlStateNormal];
  //  NSLog(@"qweqwe");
    
//}
- (IBAction)addToFavoritesFromCell:(id)sender {
    [ApplicationData addToFavorites:p];
    [sender setImage:[UIImage imageNamed:@"PostItem_Liked_18x16_.jpg"] forState:UIControlStateNormal];
}


-(IBAction)plus:(id)sender {
    int amount = 1;
    if ([[p amount] integerValue] == 100) {
        
    }else{
        amount = [p.amount intValue];
        amount++;
        p.amount = [NSNumber numberWithInt:amount];
    }
    [numberlabel setText:[NSString stringWithFormat:@"%d", amount]];
     _update_amount(1);
    
    
}

- (void) setProduct:(Product*)v{
    p = v;
    [numberlabel setText:[NSString stringWithFormat:@"%d", [p.amount intValue]]];
    _picture.image = p.previewImg;
    [_title setText:p.name];
    [_price setText:[NSString stringWithFormat:@"%@ ₽",p.price]];
}


-(IBAction)minus:(id)sender {
    int amount = 1;
    if ([[p amount] integerValue] == 1) {
        
    }else{
        amount = [p.amount intValue];
        amount--;
        p.amount = [NSNumber numberWithInt:amount];
    }
    [numberlabel setText:[NSString stringWithFormat:@"%d", amount]];
    _update_amount(1);
    
    
}

-(void) setParentTable:(UITableView *) table{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleteButton:(id)sender {
    _delete_handler(1);
}

- (void) deleteRow:(void(^)(int))handler{
    _delete_handler = [handler copy];
}

- (void) updateRow:(void(^)(int))handler{
    _update_amount = [handler copy];
}
@end
