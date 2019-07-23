//
//  ViewController.m
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ViewController1.h"
#import "ApplicationData.h"
#import "DetailsViewController.h"
#import "FirstViewController.h"
#import "../UIViewController+UIViewContollerWithSpinnerCategory.h"

@interface ViewController1 ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation ViewController1

@synthesize Collection_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UICollectionViewLayout *layout = self.Collection_view.collectionViewLayout;
    //layout.collectionViewContentSize = CGSizeMake(cellWidth, cellWidth);
    self.pageNum =@1;
    waiting = NO;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)awakeFromNib {
    //Registering CollectionViewCell
}
//
//- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *answer = [ApplicationData getCatalog];
//
//    for(int i = 1; i < [answer count]; ++i) {
//        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
//        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
//        NSInteger maximumSpacing = 4;
//        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
//
//        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < Collection_view.collectionViewContentSize.width) {
//            CGRect frame = currentLayoutAttributes.frame;
//            frame.origin.x = origin + maximumSpacing;
//            currentLayoutAttributes.frame = frame;
//        }
//    }
//    return answer;
//}

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
    
    if ([self.searchText length]!=0) {
        _product = [self.filteredProducts objectAtIndex:indexPath.row];
    }else{
        _product = [self.products objectAtIndex:indexPath.row];
    }
    
    //_product = [self.products objectAtIndex:indexPath.row];
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    UILabel *label3 = (UILabel *)[cell viewWithTag:4];
   // UILabel *label4 = (UILabel *)[cell viewWithTag:5];
    UILabel *ratingLabel = (UILabel *)[cell viewWithTag:5];
    UIButton *cartButton = (UILabel *)[cell viewWithTag:7];
    UIButton *favButton = (UILabel *)[cell viewWithTag:10];
    // индекс массива товара для корзины
    cartButton.tag = indexPath.row + 10;
    favButton.tag = indexPath.row + 10;
    
   // image1.image = [UIImage imageNamed:_product.imageName];
    image1.image = _product.previewImg;
    label1.text = [NSString stringWithFormat:@"%@ ₽",_product.price];
    label2.text = _product.name;
    //label3.text = _product.city;
    //label4.text = _product.ves;
    NSString *star = @"★";
    NSString *emptyStar = @"☆";
    NSMutableString *rateStarString = [[NSMutableString alloc]init];
    int end =[self.product.stars intValue];
    for (int i=0; i<end; i++) {
        [rateStarString appendString:star];
    }
    for (int i=end; i<5; i++) {
        [rateStarString appendString:emptyStar];
    }
    ratingLabel.text = rateStarString;
   
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized (self) {
        if (
            indexPath.row >= 45 &&
            indexPath.row >= [self.products count]-1 &&
            !waiting
            )  {
            waiting = YES;
            [self loadMoreData];
            
            
            
        }
    }
    
}

-(void)loadMoreData{
    // load data from api
    
    if ([self.pages integerValue ]>[self.pageNum integerValue] ) {
        [self showSpinner:[self view]];
        self.pageNum = @([self.pageNum integerValue] + 1);
        self.updateBlock(
                         self.pageNum,
                         ^(NSDictionary *data) {
                             self.products = [self.products arrayByAddingObjectsFromArray:[ApplicationData getProductsFromDict:data]];
                             [self.Collection_view reloadData];
                             waiting = NO;
                             [self removeSpinner];
                             
                         },
                         ^(NSString *message) {
                             waiting = NO;
                             [self removeSpinner];
                         }
                         );
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UICollectionViewCell *cell = (UICollectionViewCell*) sender;
    int item =[[Collection_view indexPathForCell:cell] row];
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
    long index = button.tag-10;
    Product *product =[self.products objectAtIndex:index];
    if ([product.stocks_quantity integerValue]<1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"К сожалению товар закончился" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [ApplicationData addToCart:product];
    [sender setImage:[UIImage imageNamed:@"cartonlyoneselect.png"] forState:UIControlStateNormal];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
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
    long index = button.tag-10;
    Product *product =[self.products objectAtIndex:index];
    [ApplicationData addToFav:product.itemId OnSuccess:^(NSDictionary *data) {
        [button setTitle:@"💖" forState:UIControlStateNormal];
    } onFailure:^(NSString *message) {
        NSLog(@"error");
    }];
}

@end
