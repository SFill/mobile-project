//
//  GNViewController.h
//  Приложение для кондитера
//
//  Created by User on 28/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *data;
    NSMutableArray *dataDescription;
    NSInteger expandedRowIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end
