#import "CatalogXMLParser.h"
#import "Product.h"


@implementation CatalogXMLParser

-(NSMutableArray*) parse
{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"catalog"
                                                          ofType:@"xml"];
                          
  
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    catalogArray = [[NSMutableArray alloc] init];
    
    if (!data)
        NSLog (@"Can't read data from url %@", filePath);
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    
    @try
    {
        if (![parser parse])
        {
            NSLog (@"Xml parsing finished with error");
        }
    }
    @catch (NSException *e)
    {
        NSLog (@"Exception '%@' while parsing Xml",[e reason]);
    }
    @finally
    {
    }
    
    return catalogArray;
}

-(void)parser:(NSXMLParser*)parser
didStartElement:(NSString*)elementName
  namespaceURI:(NSString*)namespaceURI
 qualifiedName:(NSString*)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    
    NSLog(@"Element name %@", elementName );
    
  if ([elementName isEqualToString:@"item"])
    {
        NSLog(@"Element name %@", elementName );
        
        Product *p = [[Product alloc] init];
        
        p.name = [attributeDict valueForKey:@"name"];
        p.pDescription = [attributeDict valueForKey:@"description"];
        p.price = [attributeDict valueForKey:@"price"];
        p.price2 = [attributeDict valueForKey:@"price2"];
        p.imageName = [attributeDict valueForKey:@"image"];
        p.imageName2 = [attributeDict valueForKey:@"image2"];
        p.article = [attributeDict valueForKey:@"article"];
        p.category = [attributeDict valueForKey:@"category"];
        p.city = [attributeDict valueForKey:@"city"];
        p.ves = [attributeDict valueForKey:@"ves"];
        p.stars = [attributeDict valueForKey:@"stars"];
        p.amount = [attributeDict valueForKey:@"amount"];
        p.itemId = [attributeDict valueForKey:@"itemId"];
        
        [catalogArray addObject:p];
 }
}


@end

