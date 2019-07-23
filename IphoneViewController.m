//
//  IphoneViewController.m
//  Приложение для кондитера
//
//  Created by User on 06/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "IphoneViewController.h"
#import "twoViewController.h"

@interface IphoneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *myObject;
    int i;
}

@property NSArray *image_Arr;
@property NSArray *label_Arr;
@property NSArray *price_Arr;
@end

@implementation IphoneViewController

@synthesize Collection_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    _image_Arr = [[NSMutableArray alloc]initWithObjects:@"Image_1",@"Image_2",@"Image_3",@"Image_4",@"Image_5", nil];
    _label_Arr = [[NSMutableArray alloc]initWithObjects:@"6S",@"6S Plus",@"7",@"7 Plus",@"SE", nil];
    _price_Arr = [[NSMutableArray alloc]initWithObjects:@"19 000 ₽",@"22 000 ₽",@"29 000 ₽",@"32 000 ₽",@"32 000 ₽", nil];
    
    UIImage *image1 = [UIImage imageNamed:@"Banner1-1024x368.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"banner2.jpg"];
    NSArray *images = [[NSArray alloc] initWithObjects:image1,image2,nil];
    imgView.animationImages = images;
    imgView.animationDuration = 5;
    imgView.animationRepeatCount = 0;
    [imgView startAnimating];
    // Do any additional setup after loading the view.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _image_Arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    image1.image = [UIImage imageNamed:[_image_Arr objectAtIndex:indexPath.row]];
    label1.text = [_label_Arr objectAtIndex:indexPath.row];
    label2.text = [_price_Arr objectAtIndex:indexPath.row];
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
