//
//  ViewController.m
//  Приложение для кондитера
//
//  Created by Игорь on 26/12/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ViewController.h"
#import "ApplicationData.h"
#import "DetailsViewController.h"
#import "../TableViewCell.h"
#import "../UIViewController+UIViewContollerWithSpinnerCategory.h"

@interface ViewController (){
    NSMutableArray *myObject;

    BOOL isFiltered;
    int i;
}

@property NSArray *image_Arr;
@property NSArray *label_Arr;
@property NSArray *price_Arr;
@end

@implementation ViewController

//@synthesize Collection_view;
//@synthesize сollection_view;
//@synthesize scroll;

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [scroll setScrollEnabled:YES];
//    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size.height*1.2)];
//    _image_Arr = [[NSMutableArray alloc]initWithObjects:@"монетка",@"Коробка для торта",@"краситель пищевой крафт",@"Коробка для 6 капкейков",@"монетка",@"монетка",@"монетка",@"монетка", nil];
//    _label_Arr = [[NSMutableArray alloc]initWithObjects:@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар", nil];
//    _price_Arr = [[NSMutableArray alloc]initWithObjects:@"1 100 ₽",@"2 000 ₽",@"70 ₽",@"1 260 ₽",@"1 100 ₽",@"2 000 ₽",@"2 000 ₽",@"2 000 ₽", nil];
//    
//    UIImage *image1 = [UIImage imageNamed:@"баннер вкусный 2 копия.jpg"];
//    UIImage *image2 = [UIImage imageNamed:@"баннер вкусный 2.jpg"];
//    UIImage *image3 = [UIImage imageNamed:@"баннер вкусный 3.jpg"];
//    NSArray *images = [[NSArray alloc] initWithObjects:image1,image2,image3,nil];
//    
//    imgView.animationImages = images;
//    imgView.animationDuration = 5;
//    imgView.animationRepeatCount = 0;
//    [imgView startAnimating];
//    _tableViewSearch.delegate = self;
//    _tableViewSearch.dataSource = self;
//    _tableViewSearch.hidden = true;
//    _searchBar.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _searchBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _searchBar.layer.shadowRadius = 3.0f;
//    _searchBar.layer.shadowOpacity = 1.0f;
//    _salebutton.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _salebutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _salebutton.layer.shadowRadius = 3.0f;
//    _salebutton.layer.shadowOpacity = 1.0f;
//    _newbutton.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _newbutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _newbutton.layer.shadowRadius = 3.0f;
//    _newbutton.layer.shadowOpacity = 1.0f;
//    Collection_view.layer.shadowColor = [[UIColor blackColor] CGColor];
//    Collection_view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    Collection_view.layer.shadowRadius = 3.0f;
//    Collection_view.layer.shadowOpacity = 1.0f;
//    _shadowbutton.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton.layer.shadowRadius = 3.0f;
//    _shadowbutton.layer.shadowOpacity = 1.0f;
//    _shadowbutton2.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton2.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton2.layer.shadowRadius = 3.0f;
//    _shadowbutton2.layer.shadowOpacity = 1.0f;
//    _shadowbutton3.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton3.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton3.layer.shadowRadius = 3.0f;
//    _shadowbutton3.layer.shadowOpacity = 1.0f;
//    _shadowbutton4.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton4.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton4.layer.shadowRadius = 3.0f;
//    _shadowbutton4.layer.shadowOpacity = 1.0f;
//    _shadowbutton5.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton5.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton5.layer.shadowRadius = 3.0f;
//    _shadowbutton5.layer.shadowOpacity = 1.0f;
//    _shadowbutton6.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _shadowbutton6.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    _shadowbutton6.layer.shadowRadius = 3.0f;
//    _shadowbutton6.layer.shadowOpacity = 1.0f;
//    
//    
//    
//
//    // search bar setup
//    
//    isFiltered = NO;
//    _searchBar.delegate =self;
//    
//    // Do any additional setup after loading the view.
//    
//    
//    
//    
//}
//
//
//
//- (void)viewWillAppear:(BOOL)animated{
//    [_searchBar setText: @""];
//    isFiltered = false;
//    [self showSpinner:self.view];
//    //main categories setup
//    [ApplicationData getInitialCatalogSectionsOnSuccess:^(NSDictionary *data) {
//        [self removeSpinner];
//    } onFailure:^(NSString *message) {
//        [self removeSpinner];
//    }];
//}
//
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    if (_searchBar.text.length ==0){
//        _tableViewSearch.hidden = true;
//    }else{
//          _tableViewSearch.hidden = false;
//    }
//    isFiltered = YES;
//  
//
//}
//
//
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if (searchText.length ==0) {
//        isFiltered = false;
//        _tableViewSearch.hidden = true;
//    }else{
//        isFiltered = true;
//        NSMutableArray *catalog = [ApplicationData getCatalog];
//        NSMutableArray *filteredCatalog = [[NSMutableArray alloc]init ];
//        _filteredProcuts = [[NSMutableArray alloc] init];
//        for (Product *p in catalog) {
//            NSRange match = [p.name rangeOfString:searchText];
//            if (match.location != NSNotFound) {
//                [_filteredProcuts addObject:p];
//            }
//        }
//         _tableViewSearch.hidden = false;
//          [self.tableViewSearch reloadData];
//        
//    }
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
//    //This line dismisses the keyboard.
//    [_searchBar resignFirstResponder];
//            isFiltered = false;
//    //Your view manipulation here if you moved the view up due to the keyboard etc.
//    return YES;
//}
//
//
//    
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    //return _image_Arr.count;
//    return [[ApplicationData getCatalog] count];
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    
//    Product *p = [[ApplicationData getCatalog] objectAtIndex:indexPath.row];
//    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
//    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
//    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
//    image1.image = [UIImage imageNamed:p.imageName];
//    label1.text = p.name;
//    label2.text = p.price;
////    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
////    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
////    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
////    image1.image = [UIImage imageNamed:[_image_Arr objectAtIndex:indexPath.row]];
////    label1.text = [_label_Arr objectAtIndex:indexPath.row];
////    label2.text = [_price_Arr objectAtIndex:indexPath.row];
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}
//
//
//- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
//    DetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//    vc.product = [[ApplicationData getCatalog] objectAtIndex:indexPath.row];
//    // [detail navigationController] [pushViewController:vc animated:{})];
//    [[self navigationController] pushViewController:vc animated:true];
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    DetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//    vc.product = [[ApplicationData getCatalog] objectAtIndex:indexPath.row];
//    [[self navigationController] pushViewController:vc animated:true];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"FavoritesTableViewCell";
//    
//    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavoritesTableViewCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//        Product *p = [_filteredProcuts objectAtIndex:indexPath.row];
//        [cell setProduct:p];
//    }
//    
//    return cell;
//    
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSInteger item =  [_filteredProcuts count];
//    return item;
//    
//    
//}
//
//-(IBAction)callPhone:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://89056111270"]];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
