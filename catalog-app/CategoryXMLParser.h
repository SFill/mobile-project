#import <Foundation/Foundation.h>
#import "VMCategory.h"

@interface CategoryXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *categoryArray;
}
-(NSMutableArray*) parse;


@end
