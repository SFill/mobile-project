//
//  DSSCollectionViewFlowLayout.m
//  Приложение для кондитера
//
//  Created by Игорь on 27.05.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "DSSCollectionViewFlowLayout.h"

@implementation DSSCollectionViewFlowLayout
-(void) prepareLayout{
    [super prepareLayout];
//    if(self.palceQQ){
//        CGSize cotnentSize;
//        CGSize itemSize;
//        ldiv_t cintentnByItems;
//        CGFloat LayoutSpacingValue;
//        CGFloat originMinLineSpacing;
//        CGFloat originMinInterItemSpacing;
//        UIEdgeInsets originalSectionInset;
//        
//        
//        cotnentSize = self.collectionViewContentSize;
//        itemSize = self.itemSize;
//        if(UICollectionViewScrollDirectionVertical == self.scrollDirection){
//            cintentnByItems = ldiv(cotnentSize.width, itemSize.width);
//            
//            
//        }
//        else{
//            cintentnByItems = ldiv(cotnentSize.height, itemSize.height);
//        }
//        LayoutSpacingValue = (NSInteger)((CGFloat) cintentnByItems.rem) / (CGFloat) (cintentnByItems.quot+1);
//        originMinLineSpacing = self.minimumLineSpacing;
//        originMinInterItemSpacing = self.minimumInteritemSpacing;
//        originalSectionInset = self.sectionInset;
//        if(
//           (LayoutSpacingValue != originMinLineSpacing) ||
//            (LayoutSpacingValue != originMinInterItemSpacing) ||
//            (LayoutSpacingValue != originalSectionInset.left) ||
//            (LayoutSpacingValue != originalSectionInset.right) ||
//            (LayoutSpacingValue != originalSectionInset.top) ||
//            (LayoutSpacingValue != originalSectionInset.bottom)
//           
//           ){
//            UIEdgeInsets insetsFromItem;
//            insetsFromItem.left = insetsFromItem.right = insetsFromItem.top = insetsFromItem.bottom = LayoutSpacingValue;
//            self.minimumLineSpacing = LayoutSpacingValue;
//            self.minimumInteritemSpacing = LayoutSpacingValue;
//            self.sectionInset = insetsFromItem;
//        }
//    }
    
}
@end
