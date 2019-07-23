#import "CategoryXMLParser.h"
#import "VMCategory.h"


@implementation CategoryXMLParser

-(NSMutableArray*) parse
{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"category"
                                                          ofType:@"xml"];
                          
  
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    categoryArray = [[NSMutableArray alloc] init];
    
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
    
    return categoryArray;
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
        
        VMCategory *p = [[VMCategory alloc] init];
        
        p.name = [attributeDict valueForKey:@"name"];
        
        [categoryArray addObject:p];
 }
}


@end

