//
//  twoViewController.h
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface twoViewController : UIViewController {
    
    IBOutlet UIImageView *image2;
    IBOutlet UILabel *pricelabel;
    IBOutlet UITextView *namelabel;
    IBOutlet UIImageView *stars;
    IBOutlet UILabel *otzivi;
    IBOutlet UIImageView *line1;
    IBOutlet UIImageView *nali;
    IBOutlet UILabel *labeldostavka;
    IBOutlet UIImageView *your_city;
    IBOutlet UIButton *city_buttom;
    IBOutlet UIScrollView *line2;
    IBOutlet UILabel *strana;
    IBOutlet UILabel *country;
    IBOutlet UILabel *vess;
    IBOutlet UILabel *ves;
    IBOutlet UISegmentedControl *click;
    IBOutlet UITextView *diskription;
    
    
    IBOutlet UIScrollView *scrollView;
}

@property(strong, nonatomic)NSString *strimg;

@end

NS_ASSUME_NONNULL_END
