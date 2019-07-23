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
    Product *p;
    void (^_delete_handler)(int row);
    void (^_update_amount)(int row);
}
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

-(IBAction)plus:(id)sender;
-(IBAction)minus:(id)sender;
- (IBAction)addToFavorites:(id)sender;
-(void) setProduct:(Product *) p;
- (void) deleteRow:(void(^)(int))handler;
- (void) updateRow:(void(^)(int))handler;

@property (nonatomic, copy) UITableView *parentTable;

@end

NS_ASSUME_NONNULL_END
