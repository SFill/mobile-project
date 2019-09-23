//
//  TableViewCell.m
//  Приложение для кондитера
//
//  Created by User on 03/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "TableViewCell.h"
#import "catalog-app/ApplicationData.h"
#import <SDWebImage/SDWebImage.h>


@implementation TableViewCell

//- (IBAction)addToFavorites:(id)sender {
    //[ApplicationData addToFavorites:p];
    //[sender setImage:[UIImage imageNamed:@"wishes life1.jpg"] forState:UIControlStateNormal];
  //  NSLog(@"qweqwe");
    
//}
- (IBAction)addToFavoritesFromCell:(id)sender {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSString __block *responseMessage = @"";
    BOOL __block isAdded = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [ApplicationData addToFav:self.product.itemId OnSuccess:^(NSDictionary *data) {
            isAdded = YES;
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            NSLog(@"error to add in fav");
            responseMessage = message;
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (isAdded) {
            self.product.inFav = YES;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"favWasChanged"
             object:self];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:responseMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
            [controller presentViewController:alert animated:YES completion:nil];
        }
    });
    sender = nil;
    
}


-(IBAction)plus:(id)sender {
    int amount = 1;
    if ([[self.product amount] integerValue] == 100) {
        
    }else{
        amount = [self.product.amount intValue];
        amount++;
        self.product.amount = [NSNumber numberWithInt:amount];
    }
    [numberlabel setText:[NSString stringWithFormat:@"%d", amount]];
     _update_amount(1);
    
    
}

- (void) setProduct:(Product*)p{
    _product = p;
    [numberlabel setText:[NSString stringWithFormat:@"%d", [self.product.amount intValue]]];
   // _picture.image = p.previewImg;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:p.previewImgStringURL]
              placeholderImage:[UIImage imageNamed:@"iconkulinar.png"]
     ];
    [_title setText:p.name];
    [_price setText:[NSString stringWithFormat:@"%@ ₽",p.price]];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"favWasChanged"
     object:self];
        
}


-(IBAction)minus:(id)sender {
    int amount = 1;
    if ([self.product.amount intValue] == 1) {
        
    }else{
        amount = [self.product.amount intValue];
        amount--;
        self.product.amount = [NSNumber numberWithInt:amount];
    }
    [numberlabel setText:[NSString stringWithFormat:@"%d", amount]];
    _update_amount(1);
    
    
}

-(void) setParentTable:(UITableView *) table{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(favWasChanged:)
                                                 name:@"favWasChanged"
                                               object:nil];
}
-(void)favWasChanged:(NSNotification *) notification{
    Product* searchedProduct = [ApplicationData searchInFavorites:self.product];
    
    if(searchedProduct ==nil){
       [self.favButton setImage:[UIImage imageNamed:@"PostItem_Like_18x16_.jpg"] forState:UIControlStateNormal];
        
    }else{
       [self.favButton setImage:[UIImage imageNamed:@"PostItem_Liked_18x16_.jpg"] forState:UIControlStateNormal];
    }
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
