//
//  PickPointCity.h
//  nevkusno
//
//  Created by Никита  on 25.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickPointCity : NSObject
@property NSString *Id;
@property NSString *name;
@property NSString *nameEng;
@property NSString *Owner_Id;
@property NSString *RegionName;
-(NSString*) nameFistLetter;
@end

NS_ASSUME_NONNULL_END
