## easyModel

###简介
easyModel允许你通过JSON来构造数据对象,它会自动根据model中定义的property的名称来获取JSON字串中对应的key的值，简化了从JSON到数据构造的过程:
  
 	-(instancetype)initWithDic:(NSDictionary*)dic;
	-(instancetype)initWithJson:(NSString*)jsonStr;
	+(instancetype)modelWithDic:(NSDictionary*)dic;  
	+(instancetype)modelWithJson:(NSString*)jsonStr;
  

###例子
我们一个 testType 继承于 easyModel 包含 常见的基础类型和列表其他easyModel对象，列表，常见于网络返回数据：

	@interface testType:easyModel
	
	@property(copy, nonatomic)  dispatch_block_t block;
	@property(assign, nonatomic) BOOL b;
	@property(assign, nonatomic) int i;
	@property(assign, nonatomic) unsigned int ui;
	@property(assign, nonatomic) NSInteger ni;
	@property(assign, nonatomic) NSUInteger uni;
	@property(assign, nonatomic) long l;
	@property(assign, nonatomic) long long ll;
	@property(assign, nonatomic) float f;
	@property(assign, nonatomic) double d;
	@property(copy, nonatomic) NSString *string;
	@property(copy, nonatomic) NSMutableString *mstring;
	@property(strong, nonatomic) NSNumber *number;
	@property(strong, nonatomic) NSArray<NSString> *subStrings;
	@property(strong, nonatomic)  NSArray<subTypeClass> *subTypes;
	@property(strong, nonatomic)  NSMutableArray<subTypeClass> *msubTypes;
	
	@end
	
###自定义字段解析
如果自己定义个一个model有个字段叫`otherName` 对应网络JSON返回的key为`jsonName`             ，只需要重载`initWithDic`方法即可:

 
```
@implement testType

-(instancetype)initWithDic:(NSDictionary*)dic{

  self = [supper initWithDic:dic];

  if(self){

     self.otherName = [self getStringElementForKey:@"jsonName" dic:dic];

  }
  return self;
}
@end

```

###字段解析说明
现在easyModel还不支持`NSData`和`NSDate`，因为网络JSON字串不能返回data，返回的date或者是时间戳，或者是字符串，这个根据不同的项目定义都不一样，所以可以根据具体的项目使用`自定义字段解析`的方法来实现。