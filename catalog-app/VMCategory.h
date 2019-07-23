//
//  Category.h
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMCategory : NSObject

@property (nonatomic,nullable) NSNumber *parentID;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic) BOOL *active;
@property (nonatomic, nullable) NSString *sectionDescription;
@property (nonatomic, nullable) NSString *imgUrl;


@end
