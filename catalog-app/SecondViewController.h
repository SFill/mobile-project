//
//  SecondViewController.h
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"


@interface SecondViewController : UIViewController{
    int sum;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
- (void) reloadPrices;


@end

