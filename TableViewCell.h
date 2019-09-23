//
//  TableViewCell.h
//  Приложение для кондитера
//
//  Created by User on 03/03/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "catalog-app/Product.h"
# import "catalog-app/SecondViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell {
    IBOutlet UILabel *numberlabel;
    void (^_delete_handler)(int row);
    void (^_update_amount)(int row);
}
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

-(IBAction)plus:(id)sender;
-(IBAction)minus:(id)sender;
//- (IBAction)addToFavorites:(id)sender;
-(void) setProduct:(Product *) p;
- (void) deleteRow:(void(^)(int))handler;
- (void) updateRow:(void(^)(int))handler;

@property (nonatomic, copy) UITableView *parentTable;
@property (nonatomic, copy) Product *product;

@end

NS_ASSUME_NONNULL_END
