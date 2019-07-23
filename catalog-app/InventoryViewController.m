//
//  InventoryViewController.m
//  Приложение для кондитера
//
//  Created by Admin on 13.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *myObject;
    int i;
}

@property NSArray *image_Arr;
@property NSArray *label_Arr;
@property NSArray *label1_Arr;
@property NSArray *price_Arr;
@end

@implementation InventoryViewController

@synthesize Collection_view;
@synthesize сollection_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scroll setScrollEnabled:YES];
    [_scroll setContentSize:CGSizeMake(_scroll.bounds.size.width, _scroll.bounds.size.height*1.2)];
    _image_Arr = [[NSMutableArray alloc]initWithObjects:@"монетка",@"Коробка для торта",@"краситель пищевой крафт", nil];
    _label_Arr = [[NSMutableArray alloc]initWithObjects:@"агар-агар",@"агар-агар",@"агар-агар", nil];
    _price_Arr = [[NSMutableArray alloc]initWithObjects:@"1 100 ₽",@"2 000 ₽",@"70 ₽", nil];
    _label1_Arr = [[NSMutableArray alloc]initWithObjects:@"Аэрограф кондитерский",@"Комплектующие и материалы",@"Компрессоры для аэрографа", nil];
    
    
    
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
    UILabel *label3 = (UILabel *)[cell viewWithTag:4];
    image1.image = [UIImage imageNamed:[_image_Arr objectAtIndex:indexPath.row]];
    label1.text = [_label_Arr objectAtIndex:indexPath.row];
    label2.text = [_price_Arr objectAtIndex:indexPath.row];
    label3.text = [_label1_Arr objectAtIndex:indexPath.row];
    
    
    return cell;
}



@end


