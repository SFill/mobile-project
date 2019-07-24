//
//  MainPageViewController.m
//  Приложение для кондитера
//
//  Created by Никита  on 12.07.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "MainPageViewController.h"
#import "ApplicationData.h"
#import "DetailsViewController.h"
#import "twoViewController.h"
#import "TableViewCell.h"
#import "UIViewController+UIViewContollerWithSpinnerCategory.h"
#import "catalog-app/Section.h"
#import "CollectiongroupViewController.h"
#import "catalog-app/VMPoductViewController.h"

@interface MainPageViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>{
    NSMutableArray *myObject;
    
    BOOL isFiltered;
    int i;
}

@property NSArray *image_Arr;
@property NSArray *label_Arr;
@property NSArray *price_Arr;

@end

@implementation MainPageViewController

@synthesize Collection_view;
@synthesize сollection_view;
@synthesize scroll;

- (void)viewDidLoad {
    [super viewDidLoad];
   // [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size.height*1.2)];
    _image_Arr = [[NSMutableArray alloc]initWithObjects:@"монетка",@"Коробка для торта",@"краситель пищевой крафт",@"Коробка для 6 капкейков",@"монетка",@"монетка",@"монетка",@"монетка", nil];
    _label_Arr = [[NSMutableArray alloc]initWithObjects:@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар", nil];
    _price_Arr = [[NSMutableArray alloc]initWithObjects:@"1 100 ₽",@"2 000 ₽",@"70 ₽",@"1 260 ₽",@"1 100 ₽",@"2 000 ₽",@"2 000 ₽",@"2 000 ₽", nil];
    
    UIImage *image1 = [UIImage imageNamed:@"баннер вкусный 2 копия.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"баннер вкусный 2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"баннер вкусный 3.jpg"];
    NSArray *images = [[NSArray alloc] initWithObjects:image1,image2,image3,nil];
    
    imgView.animationImages = images;
    imgView.animationDuration = 5;
    imgView.animationRepeatCount = 0;
    [imgView startAnimating];
    _tableViewSearch.delegate = self;
    _tableViewSearch.dataSource = self;
    _tableViewSearch.hidden = true;
    _searchBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    _searchBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _searchBar.layer.shadowRadius = 3.0f;
    _searchBar.layer.shadowOpacity = 1.0f;
    _salebutton.layer.shadowColor = [[UIColor blackColor] CGColor];
    _salebutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _salebutton.layer.shadowRadius = 3.0f;
    _salebutton.layer.shadowOpacity = 1.0f;
    _newbutton.layer.shadowColor = [[UIColor blackColor] CGColor];
    _newbutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _newbutton.layer.shadowRadius = 3.0f;
    _newbutton.layer.shadowOpacity = 1.0f;
    Collection_view.layer.shadowColor = [[UIColor blackColor] CGColor];
    Collection_view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    Collection_view.layer.shadowRadius = 3.0f;
    Collection_view.layer.shadowOpacity = 1.0f;
    _shadowbutton.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton.layer.shadowRadius = 3.0f;
    _shadowbutton.layer.shadowOpacity = 1.0f;
    _shadowbutton2.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton2.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton2.layer.shadowRadius = 3.0f;
    _shadowbutton2.layer.shadowOpacity = 1.0f;
    _shadowbutton3.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton3.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton3.layer.shadowRadius = 3.0f;
    _shadowbutton3.layer.shadowOpacity = 1.0f;
    _shadowbutton4.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton4.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton4.layer.shadowRadius = 3.0f;
    _shadowbutton4.layer.shadowOpacity = 1.0f;
    _shadowbutton5.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton5.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton5.layer.shadowRadius = 3.0f;
    _shadowbutton5.layer.shadowOpacity = 1.0f;
    _shadowbutton6.layer.shadowColor = [[UIColor blackColor] CGColor];
    _shadowbutton6.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _shadowbutton6.layer.shadowRadius = 3.0f;
    _shadowbutton6.layer.shadowOpacity = 1.0f;
    
    
    
    
    // search bar setup
    
    isFiltered = NO;
    _searchBar.delegate =self;
    [self.searchBar setReturnKeyType:UIReturnKeySearch];
    
    
    // async data fetch
    
    [self showSpinner:self.view];
    dispatch_group_t group = dispatch_group_create();
    //dispatch_queue_t queue = dispatch_queue_create("com.app", DISPATCH_QUEUE_CONCURRENT);
    
//    [ApplicationData setQueueForManager:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)];
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [self requestTopProducts:group];
        // need dispatch leave call
    });
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [self requestLastProducts:group];
        // need dispatch leave call
    });
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^(void){
        [self requestCatalog:group];
        // need dispatch leave call
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"All done");
       // [ApplicationData defaultQueueForManager];
        [self.topProductsCollectionView reloadData];
        [self.lastProductsCollectionView reloadData];
        [self removeSpinner];
    });
    
}



-(void) requestTopProducts:(dispatch_group_t) group{
    
    [ApplicationData getTopItems:@1 inPage:@50 OnSuccess:^(NSDictionary *data) {
        NSNumber *pages = [[data objectForKey:@"RESULT"] objectForKey:@"PAGES"];
        if (pages) {
            self.pagesTopProducts = pages;
        }
        self.topProducts = [ApplicationData getProductsFromDict:data];
        dispatch_group_leave(group);
    } onFailure:^(NSString *message) {
        NSLog(@"");
        dispatch_group_leave(group);
    }];
    
    
}
-(void) requestLastProducts:(dispatch_group_t) group{
    [ApplicationData getLastItemsForCurrentMonthWithID:@-1 withPageNum:@1 inPage:@50 OnSuccess:^(NSDictionary *data) {
        NSNumber *pages = [[data objectForKey:@"RESULT"] objectForKey:@"PAGES"];
        if (pages) {
            self.pagesLastProducts = pages;
        }
        self.lastProducts = [ApplicationData getProductsFromDict:data];
        dispatch_group_leave(group);
        
    } onFailure:^(NSString *message) {
        NSLog(@"");
         dispatch_group_leave(group);
    }];
}

-(void) requestCatalog:(dispatch_group_t) group{
    self.buttonTagDict = [[NSMutableDictionary alloc] init];
    [ApplicationData getInitialCatalogSectionsOnSuccess:^(NSDictionary *data) {
        if ([data objectForKey:@"RESULT"] == nil) {
            return;
        }
        NSArray *sections = [[data objectForKey:@"RESULT"] objectForKey:@"SECTIONS"];
        for (NSDictionary *section in sections) {
            VMCategory *category = [[VMCategory alloc] init];
            category.parentID = [NSNumber numberWithInteger:[[section objectForKey:@"PARENT"] integerValue]];
            category.ID = [NSNumber numberWithInteger:[[section objectForKey:@"ID"] integerValue]];
            category.name = [section objectForKey:@"NAME"];
            category.code = [section objectForKey:@"CODE"];
            category.sectionDescription = [section objectForKey:@"DESCRIPTION"];
            category.imgUrl =[section objectForKey:@"PICTURE"];
            if ([category.code isEqualToString:@"lavka-kulinara"]) {
                [[self buttonTagDict] setObject:category forKey:@"lavka-kulinara"];
            }
            if ([category.code isEqualToString:@"konditerskiy-inventar"]) {
                [[self buttonTagDict] setObject:category forKey:@"konditerskiy-inventar"];
            }
            if ([category.code isEqualToString:@"wholesale"]) {
                [[self buttonTagDict] setObject:category forKey:@"wholesale"];
            }
        }
         dispatch_group_leave(group);
    } onFailure:^(NSString *message) {
        //[self removeSpinner];
         dispatch_group_leave(group);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [_searchBar setText: @""];
    isFiltered = false;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (_searchBar.text.length ==0){
        _tableViewSearch.hidden = true;
    }else{
        _tableViewSearch.hidden = false;
    }
    isFiltered = YES;
    
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //[self removeSpinner];
    //[self showSpinner:self.tableViewSearch];
    if (searchText.length ==0) {
        isFiltered = false;
        _tableViewSearch.hidden = true;
        [_filteredProcuts removeAllObjects];
        [self.tableViewSearch reloadData];
    }else{
        isFiltered = true;
        self.tableViewSearch.hidden = false;
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
            [ApplicationData searchCatalog:searchText pageNum:@1 inPage:@20 OnSuccess:^(NSDictionary *data) {
                self.filteredProcuts = [ApplicationData getProductsFromDict:data];
                //[self removeSpinner];
                dispatch_group_leave(group);
            } onFailure:^(NSString *message) {
                //[self removeSpinner];
                dispatch_group_leave(group);
            }];
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"Search done");
            [self.tableViewSearch reloadData];
        });
        
        
//        NSMutableArray *catalog = [ApplicationData getCatalog];
//        NSMutableArray *filteredCatalog = [[NSMutableArray alloc]init ];
//        _filteredProcuts = [[NSMutableArray alloc] init];
//        for (Product *p in catalog) {
//            NSRange match = [p.name rangeOfString:searchText];
//            if (match.location != NSNotFound) {
//                [_filteredProcuts addObject:p];
//            }
//        }
//        _tableViewSearch.hidden = false;
//        [self.tableViewSearch reloadData];
        
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    isFiltered = false;
    //Your view manipulation here if you moved the view up due to the keyboard etc.
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     [_searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldReturn:(UISearchBar *)searchBar {
    //This line dismisses the keyboard.
    [_searchBar resignFirstResponder];
    isFiltered = false;
    //Your view manipulation here if you moved the view up due to the keyboard etc.
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *storage;
    long tag =collectionView.tag;
    if (tag == 11) {
        storage = self.topProducts;
    }
    if (tag == 10) {
        storage = self.lastProducts;
    }
    return [storage count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *storage;
    if (collectionView.tag == 11) {
        storage = self.topProducts;
    }
    if (collectionView.tag == 10) {
        storage = self.lastProducts;
    }
    
    Product *p = [storage objectAtIndex:indexPath.row];
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    image1.image = p.previewImg;
    label1.text = p.name;
    label2.text = [NSString stringWithFormat:@"%@ ₽",p.price];
    //    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    //    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    //    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    //    image1.image = [UIImage imageNamed:[_image_Arr objectAtIndex:indexPath.row]];
    //    label1.text = [_label_Arr objectAtIndex:indexPath.row];
    //    label2.text = [_price_Arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
    DetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    vc.product = [_filteredProcuts objectAtIndex:indexPath.row];
    // [detail navigationController] [pushViewController:vc animated:{})];
    [[self navigationController] pushViewController:vc animated:true];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *storage;
    if (collectionView.tag == 11) {
        storage = self.topProducts;
    }
    if (collectionView.tag == 10) {
        storage = self.lastProducts;
    }
    
    DetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    vc.product = [storage objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:vc animated:true];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FavoritesTableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FavoritesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        Product *p = [_filteredProcuts objectAtIndex:indexPath.row];
        [cell setProduct:p];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger item =  [_filteredProcuts count];
    return item;
    
    
}

-(IBAction)callPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://89056111270"]];
}
- (IBAction)lavkaClick:(id)sender {
    VMCategory *category = (VMCategory*)[[self buttonTagDict] objectForKey:@"lavka-kulinara"];
    [self segueCategories:category sender:sender];
    
}
- (IBAction)konditerClick:(id)sender {
    VMCategory *category = (VMCategory*)[[self buttonTagDict] objectForKey:@"konditerskiy-inventar"];
    [self segueCategories:category sender:sender];
}

- (IBAction)wholeClick:(id)sender {
    VMCategory *category = (VMCategory*)[[self buttonTagDict] objectForKey:@"wholesale"];
    [self segueCategories:category sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"Categories"]){
        CollectiongroupViewController *vc = [segue destinationViewController];
        vc.categories = self.dataTransferArray;
        vc.lastProducts = self.lastProducts; // сделать переименование
        vc.pagesLastProducts = self.pagesLastProducts;
    }
    if ([[segue identifier] isEqualToString:@"topProducts"]){
        VMPoductViewController *vc = [segue destinationViewController];
        vc.products = self.topProducts;
        vc.pages = self.pagesTopProducts;
        vc.pageNum = self.pageTopProducts;
        vc.updateBlock=^(NSNumber *pageNum,void (^success)(NSDictionary*),void (^failure)(NSString*)){
            
             [ApplicationData getTopItems:pageNum inPage:@50 OnSuccess:success onFailure:failure];
            
        };
        
    }
    if ([[segue identifier] isEqualToString:@"lastProducts"]){
        VMPoductViewController *vc = [segue destinationViewController];
        vc.products = self.lastProducts;
        vc.pages = self.pagesLastProducts;
        vc.pageNum = self.pageLastProducts;
        vc.updateBlock=^(NSNumber *pageNum,void (^success)(NSDictionary*),void (^failure)(NSString*)){
            [ApplicationData getLastItemsForCurrentMonthWithID:@-1 withPageNum:pageNum inPage:@50 OnSuccess:success onFailure:failure];
        };
    }
}
-(void) segueCategories:(VMCategory*) category sender: (id) sender{
    [self showSpinner:[self view]];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [ApplicationData getSubCatalogsWithID:category.ID OnSuccess:^(NSDictionary *data) {
            NSMutableArray *categrories = [[NSMutableArray alloc] init];
            if ([data objectForKey:@"RESULT"] == nil) {
                return;
            }
            
            
            NSArray *sections = [[data objectForKey:@"RESULT"] objectForKey:@"SECTIONS"];
            for (NSDictionary *section in sections) {
                VMCategory *category = [[VMCategory alloc] init];
                category.parentID = [NSNumber numberWithInteger:[[section objectForKey:@"PARENT"] integerValue]];
                category.ID = [NSNumber numberWithInteger:[[section objectForKey:@"ID"] integerValue]];
                category.name = [section objectForKey:@"NAME"];
                category.code = [section objectForKey:@"CODE"];
                category.sectionDescription = [section objectForKey:@"DESCRIPTION"];
                category.imgUrl =[section objectForKey:@"PICTURE"];
                [categrories addObject:category];
                // category.active = [[section objectForKey:@"PARENT"] boolValue];
            }
            self.dataTransferArray = categrories;
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            dispatch_group_leave(group);
            //[self removeSpinner];
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"segue to category");
        [self performSegueWithIdentifier:@"Categories" sender:sender];
        //        dispatch_async(dispatch_get_main_queue(), ^(void){
        //           [self performSegueWithIdentifier:@"Categories" sender:sender];
        //        });
        
        [self removeSpinner];
    });
    
    
    
}

@end
