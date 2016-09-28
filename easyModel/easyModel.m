//
//  easyModel
//  JdMomBaby
//
//  Created by cdyjy-cdwutao3 on 16/7/7.
//  Copyright © 2016年 jd. All rights reserved.
//

#import "easyModel.h"
#import <objc/runtime.h>

@implementation easyModel

- (id)copyWithZone:(NSZone *)zone {
    id result = [[[self class] allocWithZone:zone] init];
    return result;
}

-(id)getObjectForKey:(id)key witClass:(Class)forClass  dic:(NSDictionary*)dic
{
    id obj = [dic objectForKey:key];
    if ([obj isKindOfClass:forClass]) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
            return nil;
        } else {
            return obj;
        }
    }
    return nil;
}

-(NSString *)getStringElementForKey:(id)key dic:(NSDictionary*)dic
{
    NSString *result = @"";
    id value = [dic objectForKey:key];
    if (value) {
        if ([value isKindOfClass:[NSString class]]) {
            result = value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            result = [(NSNumber *)value stringValue];
        }
    }
    return result;
}

-(NSDictionary*)getDicElementForKey:(id)key dic:(NSDictionary*)dic{
    NSDictionary * result = [self getObjectForKey:key witClass:[NSDictionary class] dic:dic];
    if (!result) {
        result = [NSDictionary dictionary];
    }
    return result;
}

-(NSArray*)getArrayElementForKey:(id)key dic:(NSDictionary*)dic{
    NSArray* array = [self getObjectForKey:key witClass:[NSArray class] dic:dic];
    if (!array) {
        array = [NSArray array];
    }
    return array;
}

- (NSNumber *)getNumberElementForKey:(id)key dic:(NSDictionary*)dic
{
    NSNumber *result = nil;
    id value = [dic objectForKey:key];
    if (value) {
        if ([value isKindOfClass:[NSNumber class]]){
            result = value;
        }
        else if([value isKindOfClass:[NSString class]]) {
            NSString *resultStr = value;
            float resultf = [resultStr floatValue];
            result = @(resultf);
        }
        else {
            result = @([[dic objectForKey:key] integerValue]);
        }
    }
    
    if(!result) {
        result = @(0);
    }
    return result;
}

-(instancetype)initWithJson:(NSString*)jsonStr{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"error json:%@ error:%@",jsonStr,error);
        return nil;
    }
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        return [self initWithDic:jsonObj];
    }
    return nil;

}


-(instancetype)initWithDic:(NSDictionary*)dic{
    self = [super init];
    if(self){
        unsigned int properListCount;
        objc_property_t *props = class_copyPropertyList([self class], &properListCount);
        NSLog(@"count:%@",@(properListCount));
        for (unsigned int i = 0; i < properListCount; i++) {
            unsigned int properCount;
            objc_property_t pro = props[i];

            objc_property_attribute_t *attrs = property_copyAttributeList(pro, &properCount);
            
            NSString* propertyType;
            NSString *propertyName = @(property_getName(props[i]));
            for (size_t t = 0; t < properCount; ++t) {
                switch (*attrs[t].name) {
                    case 'T':
                        propertyType = @(attrs[t].value);
                        break;
                    case 'R':
                        
                    //    NSLog(@"type:%@",@(attrs[t].value));
                        break;
                    case 'N':
                        // nonatomic
                     //   NSLog(@"type:%@",@(attrs[t].value));
                        break;
                    case 'D':
                        // dynamic
                      //  NSLog(@"type:%@",@(attrs[t].value));
                        break;
                    case 'G':
                        //_getterName = @(attrs[i].value);
                     //   NSLog(@"type:%@",@(attrs[t].value));
                        break;
                    case 'S':
                        //_setterName = @(attrs[i].value);
                     //   NSLog(@"type:%@",@(attrs[t].value));
                        break;
                    default:
                        break;
                }
            }
            free(attrs);
            [self dealProprety:propertyName type:propertyType dic:dic];
        }
        
//        Ivar *ivars = class_copyIvarList([self class], &count);
//        
//        for (int i = 0; i<count; i++) {
//            
//            Ivar ivar = ivars[i];
//            const char *var_name = ivar_getName(ivar);
//            const char * var_type   = ivar_getTypeEncoding(ivar);
//            NSString *name = [NSString stringWithUTF8String:var_name+1];
//            NSString *type = [NSString stringWithUTF8String:var_type];
//            
//        }
//        free(ivars);
    }
    return self;
}

- (void)dealProprety:(NSString*)name
                type:(NSString*)type
                 dic:(NSDictionary*)dic{
    if ([type isEqualToString:@"@\"NSNumber\""]) {
        [self setValue: [self getNumberElementForKey:name dic:dic]
                forKey:name];
    }
    else if([type isEqualToString:@"q"] ||
            [type isEqualToString:@"i"] ||
            [type isEqualToString:@"I"] ||
            [type isEqualToString:@"Q"] ||
            [type isEqualToString:@"l"] ||
            [type isEqualToString:@"ll"] ||
            [type isEqualToString:@"f"] ||
            [type isEqualToString:@"d"]){
        NSNumber* number = [self getNumberElementForKey:name dic:dic];
        [self setValue:number forKey:name];
    }
    else if([type isEqualToString:@"B"]){
        NSNumber* number = [self getNumberElementForKey:name dic:dic];
        [self setValue:number forKey:name];
    }
    else if ([type isEqualToString:@"@\"NSString\""]) {
        [self setValue: [self getStringElementForKey:name dic:dic]
                forKey:name];
    }
    else if ([type isEqualToString:@"@\"NSMutableString\""]) {
        [self setValue: [[self getStringElementForKey:name dic:dic] mutableCopy]
                forKey:name];
    }
    else if ([type hasPrefix:@"@\"NSArray<"]) {
        NSArray* info = [type componentsSeparatedByString:@"<"];
        if ([info count] != 2) {
            NSAssert(nil, @"the name is error");
        }
      //  NSString* trueName = [info.firstObject substringFromIndex:2];
        NSString* className = [info.lastObject substringToIndex:[info.lastObject length]-2];
        NSArray * arrayData = [self getArrayElementForKey:name dic:dic];
        NSMutableArray * addDataArr = [NSMutableArray array];
        
        for(id arrObj in arrayData) {
            if([arrObj isKindOfClass:[NSString class]] &&
               [className isEqualToString:@"NSString"]){
                [addDataArr addObject:arrObj];
            }
            else if([arrObj isKindOfClass:[NSNumber class]] &&
                    [className isEqualToString:@"NSNumber"]){
                [addDataArr addObject:arrObj];
            }else if([arrObj isKindOfClass:[NSDictionary class]]){
                Class cls = NSClassFromString(className);
                easyModel* model = [[cls alloc] initWithDic:arrObj];
                [addDataArr addObject:model];
            }
        }
        [self setValue:[addDataArr copy]
                forKey:name];
    }
    else if ([type hasPrefix:@"@\"NSMutableArray<"]) {
        NSArray* info = [type componentsSeparatedByString:@"<"];
        if ([info count] != 2) {
            NSAssert(nil, @"the name is error");
        }
        NSString* trueName = [info.firstObject substringFromIndex:2];
        NSString* className = [info.lastObject substringToIndex:[info.lastObject length]-2];
        NSArray * arrayData = [self getArrayElementForKey:trueName dic:dic];
        NSMutableArray * addDataArr = [NSMutableArray array];
        
        for(id arrObj in arrayData) {
            if([arrObj isKindOfClass:[NSString class]] &&
               [className isEqualToString:@"NSString"]){
                [addDataArr addObject:arrObj];
            }
            else if([arrObj isKindOfClass:[NSNumber class]] &&
                    [className isEqualToString:@"NSNumber"]){
                [addDataArr addObject:arrObj];
            }else {
                Class cls = NSClassFromString(className);
                easyModel* model = [[cls alloc] initWithDic:arrObj];
                [addDataArr addObject:model];
            }
        }
        [self setValue:addDataArr
                forKey:name];
    }
    else {
        NSString* typeName = [type substringFromIndex:2];
        typeName = [typeName substringToIndex:[typeName length] -1];
        Class cls = NSClassFromString(typeName);
        NSDictionary * dataDic = [self getDicElementForKey:name dic:dic];
        if(dataDic){
            easyModel* model = [[cls alloc] initWithDic:dataDic];
            if(model){
                [self setValue:model forKey:name];
            }
        }
    }
}

+(instancetype)modelWithDic:(NSDictionary*)dic{
    Class cls = [self class];
    
    return [[cls alloc] initWithDic:dic];
}

+(instancetype)modelWithJson:(NSString*)jsonStr{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"error json:%@ error:%@",jsonStr,error);
        return nil;
    }
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        return [self modelWithDic:jsonObj];
    }
    return nil;
}
@end
