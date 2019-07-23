//
//  SecondViewController.m
//  catalog-app
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "SecondViewController.h"
#import "ApplicationData.h"
#import "TableViewCell.h"
#import "../CheckoutViewController.h"


@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self reloadPrices];
    
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
    [self reloadPrices];
}

- (void) reloadPrices{
    NSMutableArray *cart = [ApplicationData getCart];
    sum=0;
    NSRange match;
    
    for(int i=0;i<[cart count];i++){
        NSString *price =[[cart objectAtIndex: i] price];
        NSNumber *amount = [[ cart objectAtIndex:i] amount];
        //match = [price rangeOfString: @"₽"];
        //NSString *price2 = [price substringWithRange: NSMakeRange (0, match.location)];
        sum+= [price intValue] * [amount intValue];
    }
    self.label1.text = [[NSMutableString alloc] initWithFormat:@"%d ₽", sum];
    self.label.text = [[NSMutableString alloc] initWithFormat:@"%d ₽", sum];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[ApplicationData getCart] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            Product *p = [[ApplicationData getCart] objectAtIndex:indexPath.row];
            [cell setProduct:p];
            [cell deleteRow:^(int result){
                NSMutableArray *cart = [ApplicationData getCart];
                Product* p = [[ApplicationData getCart] objectAtIndex:indexPath.row];
                p.amount = [NSNumber numberWithInt:1];
                [[ApplicationData getCart] removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                [self reloadPrices];
            }];
            [cell updateRow:^(int result){
                [self reloadPrices];
            }];
    }
    return cell;

}

- (IBAction)refreshAndPushNext:(id)sender {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CheckoutViewController *vc = segue.destinationViewController;
    vc.adb_rg = self.label1.text;
    
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (sum<500) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Заказ менее чем на 500 рублей" message:@"Для совершения заказа, необходима сумма свыше 500 рублей" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return false;
        
    }
    return true;
}







@end
