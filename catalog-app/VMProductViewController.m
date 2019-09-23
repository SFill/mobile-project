//
//  ViewController.m
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "VMProductViewController.h"
#import "ApplicationData.h"
#import "DetailsViewController.h"
#import "FirstViewController.h"
#import "../UIViewController+UIViewContollerWithSpinnerCategory.h"
#import "../ReusableCollectionViewCells/FooterCollectionReusableView.h"
#import <SDWebImage/SDWebImage.h>

@interface VMProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (atomic) BOOL waiting;

@end

@implementation VMProductViewController

@synthesize Collection_view;

- (void)viewDidLoad {
    [super viewDidLoad];
//TODO push-and-load
    self.pageNum =@1;
    self.waiting = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(productStateWasChanged:)
                                                 name:@"favWasChanged"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(productStateWasChanged:)
                                                 name:@"cartWasChanged"
                                               object:nil];
}
-(void)productStateWasChanged:(NSNotification *) notification{
    [self.Collection_view reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(UICollectionReusableView*) collectionView:(UICollectionView*) collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    FooterCollectionReusableView *theView;
    
    if(kind == UICollectionElementKindSectionHeader)
    {
        // TODO header будет позже
        theView = [self.Collection_view dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    } else {
        theView = [self.Collection_view dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusabelView" forIndexPath:indexPath];
        [theView.dataLoadingAi startAnimating];
        if (!self.waiting & ([self.pages integerValue ]==[self.pageNum integerValue]) ) {
            [theView setFrame:CGRectMake(0, 0, theView.frame.size.width, 0)];
        }
       // [theView.refreshButton setTitle:@"qweqweqwe" forState:UIControlStateNormal];
    }
    
    return theView;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double cellWidth = (self.view.frame.size.width -20) / 2;
    return CGSizeMake(cellWidth, cellWidth*1.5);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.searchText length]==0) {
        return [self.products count];
    }
    return [self.filteredProducts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Product *product;
    if ([self.searchText length]!=0) {
         product = [self.filteredProducts objectAtIndex:indexPath.row];
    }else{
        product = [self.products objectAtIndex:indexPath.row];
    }
    
    //_product = [self.products objectAtIndex:indexPath.row];
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
   // UILabel *label3 = (UILabel *)[cell viewWithTag:4];
   // UILabel *label4 = (UILabel *)[cell viewWithTag:5];
    UILabel *ratingLabel = (UILabel *)[cell viewWithTag:5];
    UIButton *cartButton = (UIButton *)[cell viewWithTag:7];
    UIButton *favButton = (UIButton *)[cell viewWithTag:10];
    // индекс массива товара для корзины
//    cartButton.tag = indexPath.row + 10;
//    favButton.tag = indexPath.row + 10;
    
    if ([ApplicationData searchInFavorites:product]) {
        [favButton setTitle:@"💖" forState:UIControlStateNormal];
        
    }else{
        [favButton setTitle:@"❤️" forState:UIControlStateNormal];
    }
    
    if ([ApplicationData searchCart:product]) {
        [cartButton setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
       
    }else if ([product.stocks_quantity intValue] !=0) {
         [cartButton setImage:[UIImage imageNamed:@"TabBar_gift_23x23_enable.png"] forState:UIControlStateNormal];
        
    }else{
       [cartButton setImage:[UIImage imageNamed:@"TabBar_gift_23x23_.png"] forState:UIControlStateNormal];
        }
   // image1.image = [UIImage imageNamed:_product.imageName];
    //image1.image = product.previewImg;
    [image1 sd_setImageWithURL:[NSURL URLWithString:product.previewImgStringURL]
              placeholderImage:[UIImage imageNamed:@"iconkulinar.png"]
     ];
    label1.text = [NSString stringWithFormat:@"%@ ₽",product.price];
    label2.text = product.name;
    //label3.text = _product.city;
    //label4.text = _product.ves;
    NSString *star = @"★";
    NSString *emptyStar = @"☆";
    NSMutableString *rateStarString = [[NSMutableString alloc]init];
    int end =[product.stars intValue];
    for (int i=0; i<end; i++) {
        [rateStarString appendString:star];
    }
    for (int i=end; i<5; i++) {
        [rateStarString appendString:emptyStar];
    }
    ratingLabel.text = rateStarString;
   
    
    
    return cell;
}

//
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized (self) {
        if (indexPath.row >= 45 &&
            indexPath.row >= [self.products count]-1 &&
            !self.waiting
            )
        {
            self.waiting = YES;
            [self loadMoreData];
        }
    }

}

-(void)loadMoreData{
    // load data from api
    
    if ([self.pages integerValue ]>[self.pageNum integerValue] ) {
      //  [self showSpinner:[self view]];
        self.pageNum = @([self.pageNum integerValue] + 1);
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
            self.updateBlock(
                             self.pageNum,
                             ^(NSDictionary *data) {
                                 for (Product *product in [ApplicationData getProductsFromDict:data]) {
                                     [self.products addObject:product];
                                 }
                                 
                                 self.waiting = NO;
                                 dispatch_group_leave(group);
                             },
                             ^(NSString *message) {
                                 self.waiting = NO;
                                 dispatch_group_leave(group);
                             }
                             );
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"fetch new content has finished");
            [self.Collection_view reloadData];
       //     [self removeSpinner];
        });
        
    }else{
        self.waiting = NO;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UICollectionViewCell *cell = (UICollectionViewCell*) sender;
    long item =[[Collection_view indexPathForCell:cell] row];
    DetailsViewController *vc = segue.destinationViewController;
    vc.product = [self.products  objectAtIndex:item];
}





    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToCartFromCollectionView:(id)sender {
    UIButton *button = (UIButton*) sender;
    UICollectionViewCell *cell =(UICollectionViewCell*)[button superview].superview; // иначе не работает
    NSIndexPath *i  =[self.Collection_view indexPathForCell:cell];
    long index =[i row];
    Product *product =[self.products objectAtIndex:index];
    if ([product.stocks_quantity integerValue]<1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"К сожалению товара нет в наличии" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [ApplicationData addToCart:product];
    [sender setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
    product.inCart = YES;
    [self.Collection_view reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = [[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString];
    self.filteredProducts = [[NSMutableArray alloc] init];
    for (Product *product in self.products) {
        NSRange match = [product.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (match.location != NSNotFound) {
            [self.filteredProducts addObject:product];
        }
    }
    [self.Collection_view reloadData];
}

- (IBAction)addToFav:(id)sender {
    UIButton *button = (UIButton*) sender;
    UICollectionViewCell *cell =(UICollectionViewCell*)[button superview].superview; // иначе не работает
    NSIndexPath *i  =[self.Collection_view indexPathForCell:cell];
    long index =[i row];
    __block BOOL isAdded = NO;
    Product *product =[self.products objectAtIndex:index];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSString __block *responseMessage = @"";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [ApplicationData addToFav:product.itemId OnSuccess:^(NSDictionary *data) {
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
            product.inFav = YES;
            [button setTitle:@"💖" forState:UIControlStateNormal];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:responseMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
            [controller presentViewController:alert animated:YES completion:nil];
        }
    });
    sender = nil;
    button = nil;
}

@end
