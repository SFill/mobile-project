//
//  GNViewController.m
//  Приложение для кондитера
//
//  Created by User on 28/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

#import "GNViewController.h"
#import "GNTableViewCell.h"
#import "GNDropTableViewCell.h"
#import "DetailTextDeliveryVCViewController.h"
#import "PickPointViewController.h"


@implementation GNViewController

- (void)viewDidLoad {
    [_scroll setScrollEnabled:YES];
    [_scroll setContentSize:CGSizeMake(_scroll.bounds.size.width, _scroll.bounds.size.height*1.2)];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    expandedRowIndex = -1;
    data = [NSMutableArray new];
    dataDescription = [NSMutableArray new];
    
    [data addObject:@"1. Курьерская доставка по Москве и Подмосковью"];
    [dataDescription addObject:@"Преимущества - доставка на следующий день после заказа на дом, возможны замороженные продукты в заказе.   Стоимость доставки в пределах МКАД - 359 руб. Доставка осуществляется в выбранный покупателем день.     Стоимость доставки за МКАД составляет 25 руб. за км.     Доставка за МКАД осуществляется в течении 1-3 рабочих дней после подтверждения заказа.Вы получаете заказанный товар, кассовый чек и товарный чек и, проверив соответствие привезённого товара сопроводительным документам, оплачиваете товар наличными рублями. Все товары сертифицированы. Внимание!  Внимательно проверяйте соответствие заказа с бланком заказа.      После того, как Вы поставили подпись в бланке, что Товар получен полностью. Претензий к внешнему виду и составу заказа не имею, претензии по составу заказа и внешнему виду товара не принимаются. Просим с пониманием отнестись к данным правилам."];
    [data addObject:@"2. Срочная курьерская доставка по Москве день в день"];
    [dataDescription addObject:@"Преимущества - доставка день в день   Стоимость доставки в пределах МКАД - 499 руб. Вес посылки до 15 кг.  Заказ должен быть отправлен до 14.00"];
    [data addObject:@"3. Доставка через постаматы и пункты выдачи PickPoint"];
    [dataDescription addObject:@"Преимущества - более 1500 пунктов выдачи по всей России, по Москве и Подмосковью не требуется предоплата, фиксированная стоимость доставки. Возможна оплатой картой при получении. Стоимость доставки:   Москва и Санкт Петербург - 420 руб.   Доставка в Регионы - расчет производит оператор. Вес посылки до 10 кг. Внимание! Посылки по Москве и Подмосковью отправляются без предоплаты, покупатель оплачивает при получении. Посылки в Регионы отправляются по 100% предоплате.  Постамат – автоматизированный посылочный терминал, куда доставляется Ваш заказ. Далее Вы самостоятельно забираете заказ в удобное Вам время, следуя инструкциям в меню терминала."];
    [data addObject:@"4. Доставка СДЭК"];
    [dataDescription addObject:@"Преимущества - более 1000 пунктов выдачи по всей России. Выдача в пунктах самовывоза и доставка до двери. Низкая стоимость. Расчет доставки при оформлении заказа на сайте. Стоимость доставки автоматически рассчитывается в корзине на сайте, в зависимости от веса посылки. Вес посылки до 30 кг."];
    [data addObject:@"5. Доставка по России"];
    [dataDescription addObject:@"Почта России \n   Стоимость доставки в Дальневосточный, Сибирский, Северо-западный (Коми, Мурманск) и Уральский федеральные округа, указанная в таблице, умножается на 2 Амурская область, Камчатский край, Магаданская область, Приморский край, Сахалинская область, Саха (Якутия), Хабаровский край, Чукотский округ, Алтайский край, Забайкальский край, Иркутская область, Красноярский край, Кемеровская область, Новосибирская область, Омская область, Республика Алтай, Республика Бурятия, Республика Тыва, Республика Хакасия, Томская область, Курганская область, Свердловская область, Тюменская область, Ханты-Мансийский автономный округ, Челябинская область, Ямало-ненецкий автономный округ\n Примечание: стоимость доставки заказа от 20 000 руб. и с весом посылки свыше 10 кг., а также Саратов, Саратовская область, Норильск и Магадан - рассчитывается отдельно оператором.  - Доставка через постаматы и пункты выдачи PickPoint Укажите при оформлении корзины наиболее предпочтительный способ доставки, оператор рассчитает стоимость доставки Вашего заказа (если нет фиксированной стоимости), перезвонит Вам для подтверждения. Затем выставляется счет с указанием реквизитов. Оплатить счет можно в любом отделении Сбербанка."];
    [data addObject:@"6. Доставка Транспортными компаниями"];
    [dataDescription addObject:@"Преимущества - более дешевая доставка при большом весе заказа. Доставка осуществляется Транспортной компанией Деловые линии. Стоимость доставки рассчитывается отдельно оператором. К стоимости доставки прибавляется 600 руб. (услуги курьера). Либо вы можете сами вызвать к нам любую ТК на ваше усмотрение. Можно рассчитать предварительно стоимость, введя вес и объем заказа - http://www.dellin.ru/"];
    [data addObject:@"7. Самовывоз по Москве и Подмосковью"];
    [dataDescription addObject:@"Преимущества - более дешевая доставка при большом весе заказа. Доставка осуществляется Транспортной компанией Деловые линии. Стоимость доставки рассчитывается отдельно оператором. К стоимости доставки прибавляется 600 руб. (услуги курьера). Либо вы можете сами вызвать к нам любую ТК на ваше усмотрение. Можно рассчитать предварительно стоимость, введя вес и объем заказа - http://www.dellin.ru/"];
    


}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count] + (expandedRowIndex != -1 ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger dataIndex = [self dataIndexForRowIndex:row];
    NSString *dataObject = [data objectAtIndex:dataIndex];
    
    BOOL expandedCell = expandedRowIndex != -1 && expandedRowIndex + 1 == row;
    
    if (!expandedCell)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"data"];
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"data"];
        cell.textLabel.text = dataObject;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        return cell;
    }
    else
    {
//        GNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GNTableViewCell"];
//        cell.textLabelDescription.text = [dataDescription objectAtIndex:dataIndex];
//        if (cell == nil) {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GNTableViewCell" owner:self options:nil];
//            cell = [nib objectAtIndex:0];
//            cell.textLabelDescription.text = [dataDescription objectAtIndex:dataIndex];
        GNDropTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GNDropTableViewCell"];
        cell.textLabel.text = [dataDescription objectAtIndex:dataIndex];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GNDropTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.textLabel.text = [dataDescription objectAtIndex:dataIndex];
//            Product *p = [[ApplicationData getCart] objectAtIndex:indexPath.row];
//            [cell setProduct:p];
//            [cell deleteRow:^(int result){
//                NSMutableArray *cart = [ApplicationData getCart];
//                Product* p = [[ApplicationData getCart] objectAtIndex:indexPath.row];
//                p.amount = [NSNumber numberWithInt:1];
//                [[ApplicationData getCart] removeObjectAtIndex:indexPath.row];
//                [self.tableView reloadData];
//                [self reloadPrices];
//            }];
//            [cell updateRow:^(int result){
//                [self reloadPrices];
//            }];
        }
//        cell.font = [UIFont systemFontOfSize:9.0];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"Преимущества - доставка на следующий день после заказа на дом, возможны замороженные продукты в заказе. Стоимость доставки в пределах МКАД - 359 руб. Доставка осуществляется в выбранный покупателем день. Стоимость доставки за МКАД составляет 25 руб. за км. Доставка за МКАД осуществляется в течении 1-3 рабочих дней после подтверждения заказа. Вы получаете заказанный товар, кассовый чек и товарный чек и, проверив соответствие привезённого товара сопроводительным документам, оплачиваете товар наличными рублями. Все товары сертифицированы. Внимание! Внимательно проверяйте соответствие заказа с бланком заказа. После того, как Вы поставили подпись в бланке, что Товар получен полностью. Претензий к внешнему виду и составу заказа не имею, претензии по составу заказа и внешнему виду товара не принимаются. Просим с пониманием отнестись к данным правилам. '%@'", dataObject];
        return cell;
//        if (!cell)
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"expanded"];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:9.0];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"Преимущества - доставка на следующий день после заказа на дом, возможны замороженные продукты в заказе. Стоимость доставки в пределах МКАД - 359 руб. Доставка осуществляется в выбранный покупателем день. Стоимость доставки за МКАД составляет 25 руб. за км. Доставка за МКАД осуществляется в течении 1-3 рабочих дней после подтверждения заказа. Вы получаете заказанный товар, кассовый чек и товарный чек и, проверив соответствие привезённого товара сопроводительным документам, оплачиваете товар наличными рублями. Все товары сертифицированы. Внимание! Внимательно проверяйте соответствие заказа с бланком заказа. После того, как Вы поставили подпись в бланке, что Товар получен полностью. Претензий к внешнему виду и составу заказа не имею, претензии по составу заказа и внешнему виду товара не принимаются. Просим с пониманием отнестись к данным правилам. '%@'", dataObject];
//        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    BOOL preventReopen = NO;
    
    if (row == expandedRowIndex + 1 && expandedRowIndex != -1)
        return nil;
    
    [tableView beginUpdates];
    
    if (expandedRowIndex != -1)
    {
        NSInteger rowToRemove = expandedRowIndex + 1;
        
        preventReopen = row == expandedRowIndex;
        if (row > expandedRowIndex)
            row--;
        expandedRowIndex = -1;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    NSInteger rowToAdd = -1;
    if (!preventReopen)
    {
        rowToAdd = row + 1;
        expandedRowIndex = row;
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowToAdd inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        
    }
    [tableView endUpdates];
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (expandedRowIndex != -1 && row == expandedRowIndex + 1)
        return 300;
    return 40;
}

- (NSInteger)dataIndexForRowIndex:(NSInteger)row
{
    if (expandedRowIndex != -1 && expandedRowIndex <= row)
    {
        if (expandedRowIndex == row)
            return row;
        else
            return row - 1;
    }
    else
        return row;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray *detailTextButtons = @[@1, @2, @4,@6];
    
     UIButton *button = (UIButton*) sender;
    if ([detailTextButtons containsObject:@(button.tag)]) {
        DetailTextDeliveryVCViewController *vc = segue.destinationViewController;
        
        //vc.adb_rg = self.label1.text;
        if (button.tag ==1){
            vc.advantagesTextIntent = @"Преимущества - доставка на следующий день после заказа на дом, возможны замороженные продукты в заказе";
            vc.deliveryTextIntent= @"- Стоимость доставки в пределах МКАД - 359 руб. \nДоставка осуществляется в выбранный покупателем день. \n- Стоимость доставки за МКАД составляет 25 руб. за км. \nДоставка за МКАД осуществляется в течении 1-3 рабочих дней после подтверждения заказа. \nВы получаете заказанный товар, кассовый чек и товарный чек и, проверив соответствие привезённого товара сопроводительным документам, оплачиваете товар наличными рублями. \nВсе товары сертифицированы. \n\nВнимание! \n Внимательно проверяйте соответствие заказа с бланком заказа. \nПосле того, как Вы поставили подпись в бланке, что Товар получен полностью. Претензий к внешнему виду и составу заказа не имею, претензии по составу заказа и внешнему виду товара не принимаются. Просим с пониманием отнестись к данным правилам.";
        }else if(button.tag ==2){
            vc.advantagesTextIntent = @"Преимущества - доставка день в день";
            vc.deliveryTextIntent= @"Стоимость доставки в пределах МКАД - 499 руб. Вес посылки до 15 кг. \nЗаказ должен быть отправлен до 14.00";
        }else if(button.tag ==4){
            vc.advantagesTextIntent = @"Преимущества - более 1000 пунктов выдачи по всей России";
            vc.deliveryTextIntent= @"Выдача в пунктах самовывоза и доставка до двери. Низкая стоимость. Расчет доставки при оформлении заказа на сайте. Стоимость доставки автоматически рассчитывается в корзине на сайте, в зависимости от веса посылки. \nВес посылки до 30 кг.";
        }else if(button.tag ==6){
            vc.advantagesTextIntent = @"Преимущества - более дешевая доставка при большом весе заказа. Доставка осуществляется Транспортной компанией Деловые линии.";
            vc.deliveryTextIntent= @"Стоимость доставки рассчитывается отдельно оператором. К стоимости доставки прибавляется 600 руб. (услуги курьера). Либо вы можете сами вызвать к нам любую ТК на ваше усмотрение. Можно рассчитать предварительно стоимость, введя вес и объем заказа - http://www.dellin.ru/";
        }
        
    }
    
    
    
}



@end
