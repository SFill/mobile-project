//
//  ThirstViewController.h
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirstViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;


@end

