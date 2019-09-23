//
//  CollectiongroupViewController.m
//  Приложение для кондитера
//
//  Created by User on 17/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "CollectiongroupViewController.h"
#import "catalog-app/ApplicationData.h"
#import "catalog-app/VMProductViewController.h"
#import "UIViewController+UIViewContollerWithSpinnerCategory.h"
#import "Segues/UIStoryboardSegueToItself.h"
#import "catalog-app/DetailsViewController.h"


@interface CollectiongroupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *myObject;
    int i;
}

@property NSArray *image_Arr;
@property NSArray *label_Arr;
@property NSArray *label1_Arr;
@property NSArray *price_Arr;
@end

@implementation CollectiongroupViewController

@synthesize Collection_view;
@synthesize сollection_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scroll setScrollEnabled:YES];
    [_scroll setContentSize:CGSizeMake(_scroll.bounds.size.width, _scroll.bounds.size.height*1.2)];
    _image_Arr = [[NSMutableArray alloc]initWithObjects:@"монетка",@"Коробка для торта",@"краситель пищевой крафт",@"Коробка для 6 капкейков",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка",@"монетка", nil];
    _label_Arr = [[NSMutableArray alloc]initWithObjects:@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар",@"агар-агар", nil];
    _price_Arr = [[NSMutableArray alloc]initWithObjects:@"1 100 ₽",@"2 000 ₽",@"70 ₽",@"1 260 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽",@"1 100 ₽", nil];
    _label1_Arr = [[NSMutableArray alloc]initWithObjects:@"Аэрография",@"Бумажные формы для выпечки",@"Вайнеры цветочные",@"Вырубки и каттеры для пряников, печенья и мастики",@"Инструменты для работы с кремом",@"Инструменты для работы с мастикой и тестом",@"Кондитерские принадлежности",@"Книги для кондитера, журналы",@"Кухонные приборы и утварь",@"Коврики для айсинга",@"Молды и маты силиконовые",@"Молды пластиковые для шоколада, мастики",@"Муляж для торта",@"Подложки, салфетки",@"Подставки и тарелки для тортов, кексов и кейкпопсов",@"Поликарбонатные формы для конфет",@"Принтер пищевой, пищевая бумага",@"Расходники для приготовления и хранения",@"Трафареты, штампы, пэчворки",@"Упаковка для кондитерских изделий",@"Упаковочные материалы",@"Флористика",@"Формы для выпечки",@"Формы для выпечки раздвижные, резаки",@"Формы для шоколада, печенья, леденцов, кейкпопсов и мороженого", nil];
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray* storage;
    if ([self.searchText length]!=0) {
        storage = self.filteredCategories;
    }else{
        storage = self.categories;
    }
//    if (collectionView.tag ==11) {
//        storage = self.categories;
//    }
    
//    if (collectionView.tag ==10) {
//         storage = self.lastProducts;
//    }
    return [storage count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//
//        UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
//        UILabel *priceProductLabel = (UILabel *)[cell viewWithTag:3];
    
    UILabel *categoryNameLabel = (UILabel *)[cell viewWithTag:4];
    if ([self.searchText length]!=0) {
        categoryNameLabel.text = [[self.filteredCategories objectAtIndex:indexPath.row] name];
    }else{
        categoryNameLabel.text = [[self.categories objectAtIndex:indexPath.row] name];
    }
    
    
    
//    if (collectionView.tag ==11) {
//        UILabel *categoryNameLabel = (UILabel *)[cell viewWithTag:4];
//        categoryNameLabel.text = [[_categories objectAtIndex:indexPath.row] name];
//    }
    
//    if (collectionView.tag ==10) {
//        Product *product = [self.lastProducts objectAtIndex:indexPath.row];
//        image1.image = product.previewImg;
//        priceProductLabel.text =[NSString stringWithFormat:@"%@ ₽",product.price];;
//    }
    

//    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
//    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
//    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
//    UILabel *label3 = (UILabel *)[cell viewWithTag:4];

//    label2.text = [_price_Arr objectAtIndex:indexPath.row];
//    label3.text = [_label1_Arr objectAtIndex:indexPath.row];
    

    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag ==11) {
        VMCategory *category = [self.categories objectAtIndex:indexPath.row];
        self.selectedCategory = category;
        [self segueCategories:category sender:self];
    }
    
    if (collectionView.tag ==10) {
        DetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        vc.product = [self.lastProducts objectAtIndex:indexPath.row];
        [[self navigationController] pushViewController:vc animated:true];
    }
    
    
   
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"toItself"]){
        CollectiongroupViewController *vc = [segue destinationViewController];
        vc.categories = self.dataTransferArray;
        vc.pagesLastProducts = self.pagesLastProducts;
        vc.lastProducts = self.lastProducts;
        vc.navigationItem.title =self.selectedCategory.name;
        
    }
    if ([[segue identifier] isEqualToString:@"toProducts"]) {
        VMProductViewController *vc = [segue destinationViewController];
        vc.products = [self dataTransferArray];
        vc.category = [self selectedCategory];
        vc.pages =self.pages;
        vc.navigationItem.title = self.selectedCategory.name;
        vc.updateBlock=^(NSNumber *pageNum,void (^success)(NSDictionary*),void (^failure)(NSString*)){
            [ApplicationData getCatalogItemsWithID:[self selectedCategory].ID withPageNum:pageNum OnSuccess:success onFailure:failure];
        };
    }
    if ([[segue identifier] isEqualToString:@"toLastProducts"]) {
        VMProductViewController *vc = [segue destinationViewController];
        vc.products = self.lastProducts;
        vc.category = [self selectedCategory];
        vc.pages =self.pagesLastProducts;
        vc.updateBlock=^(NSNumber *pageNum,void (^success)(NSDictionary*),void (^failure)(NSString*)){
            [ApplicationData getLastItemsForCurrentMonthWithID:@-1 withPageNum:pageNum inPage:@50 OnSuccess:success onFailure:failure];
        };
    }
    
}
-(void) segueCategories:(VMCategory*) category sender: (id) sender{
    [self showSpinner:[self view]];
    dispatch_group_t group =dispatch_group_create();
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
            }
            self.dataTransferArray = categrories;
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
            NSLog(@"");
            [self removeSpinner];
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"segue to category");
        if (![self.dataTransferArray count]) {
            [self segueProducts:category sender:sender];
            return;
        }
        UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryCollectionView"];
        UIStoryboardSegueToItself *segue = [[UIStoryboardSegueToItself alloc] initWithIdentifier:@"toItself" source:self destination:toViewController];
        [self prepareForSegue:segue sender:self];
        [segue perform];
        [self removeSpinner];
    });
    
    
}
-(void) segueProducts:(VMCategory*) category sender: (id) sender{
    dispatch_group_t group =dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [ApplicationData getCatalogItemsWithID:category.ID withPageNum:@1 OnSuccess:^(NSDictionary *data){
            self.selectedCategory = category;
            NSNumber *pages = nil;
            pages = [[data objectForKey:@"RESULT"] objectForKey:@"PAGES"];
            if (pages) {
                self.pages = pages;
            }
            self.dataTransferArray = [ApplicationData getProductsFromDict:data];
            dispatch_group_leave(group);
        } onFailure:^(NSString *message) {
           dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"segue to products");
        UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
        UIStoryboardSegueToItself *segue = [[UIStoryboardSegueToItself alloc] initWithIdentifier:@"toProducts" source:self destination:toViewController];
        [self prepareForSegue:segue sender:self];
        [segue perform];
        [self removeSpinner];
    });
    
    
}

-(void) segueToLastProducts:(id) sender{
    UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
    UIStoryboardSegueToItself *segue = [[UIStoryboardSegueToItself alloc] initWithIdentifier:@"toLastProducts" source:self destination:toViewController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
    [self removeSpinner];
    
}
- (IBAction)showLastProducts:(id)sender {
    [self segueToLastProducts:sender];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = [[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString];
    self.filteredCategories = [[NSMutableArray alloc] init];
    for (VMCategory *category in self.categories) {
        NSRange match = [category.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (match.location != NSNotFound) {
            [self.filteredCategories addObject:category];
        }
    }
    [self.categoryCollectionView reloadData];
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
