#import <Foundation/Foundation.h>
#import "Product.h"

@interface CatalogXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *catalogArray;
}
-(NSMutableArray*) parse;


@end
