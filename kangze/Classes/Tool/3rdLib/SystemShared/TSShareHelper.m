//
//  TSShareHelper.m
//  ShareMorePicToWX
//  https://github.com/TsnumiDC/TSShareHelper
//  Created by Dylan Chen on 2017/5/26.
//  Copyright © 2017年 Dylan. All rights reserved.
//

#import "TSShareHelper.h"
#import <Social/Social.h>
#import "GYZSharedItem.h"

@interface TSShareHelper()

@property (strong, nonatomic)UIViewController * pushVC;

@end
@implementation TSShareHelper

static TSShareHelper * shareHelper;

#pragma mark - 单例
+ (instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHelper = [[TSShareHelper alloc]init];
    });
    return shareHelper;
}

#pragma mark - Public
+ (BOOL)shareWithType:(TSShareHelperShareType)type
        andController:(UIViewController *)controller
          andFilePath:(NSString *)path
        andCompletion:(TSShareHelperCompleteHandler)completion{
    
    return [TSShareHelper shareWithType:type
                          andController:controller
                             andFileURL:[NSURL fileURLWithPath:path]
                          andCompletion:completion];
    
}

+ (BOOL)shareWithType:(TSShareHelperShareType)type
        andController:(UIViewController *)controller
           andFileURL:(NSURL *)url
        andCompletion:(TSShareHelperCompleteHandler)completion{
    
   return [TSShareHelper
           shareWithType:type
           andController:controller
           andItems:@[url]
           andCompletion:completion];
}


+ (BOOL)shareWithType:(TSShareHelperShareType)type
        andController:(UIViewController *)controller
             andItems:(NSArray *)items
        andCompletion:(TSShareHelperCompleteHandler)completion{
    
    return [[TSShareHelper shareHelper]shareWithType:type andController:controller andItems:items andCompletion:completion];
}

- (BOOL)shareWithType:(TSShareHelperShareType)type
        andController:(UIViewController *)controller
             andItems:(NSArray *)items
        andCompletion:(TSShareHelperCompleteHandler)completion {

    __block BOOL  success = YES;
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) {
        
        type = TSShareHelperShareTypeOthers;//11之后只有分享到面板,然后选
        
    } else {
        // 针对 11.0 以下的iOS系统进行处理
    }
    
    //判断分享类型
    if(type == TSShareHelperShareTypeOthers){
        
        UIActivityViewController * activityCtl = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
        //尽量不显示其他分享的选项内容
        activityCtl.excludedActivityTypes = @[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
        [controller presentViewController:activityCtl animated:YES completion:^{
            
            
        }  ];
        
        activityCtl.completionWithItemsHandler = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError) {
            if (completed) { // 确定分享
                if (completion) {
                    completion(self,YES);
                }
            } else {
                completion(self,YES);
            } };
        
        return YES;
    }
    
    NSString * serviceType = [self serviceTypeWithType:type];
//    if (![SLComposeViewController isAvailableForServiceType:serviceType]) {
//
//        NSLog(@"不可用");
//        return NO;
//    }

    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    // 添加要分享的图片
    self.pushVC = composeVC;
    
    for ( id obj in items){
        if ([obj isKindOfClass:[UIImage class]]){
            [composeVC addImage:(UIImage *)obj];
        }else if ([obj isKindOfClass:[NSURL class]]){
            [composeVC addURL:(NSURL *)obj];
        }
    }

    // 添加要分享的文字
    [composeVC setInitialText:@"分享"];

    // 弹出分享控制器
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
           // NSLog(@"点击了发送");
            
        }
        else if (result == SLComposeViewControllerResultCancelled) {
           // NSLog(@"点击了取消");
            success = NO;
        }
    };
    
    @try{
        [controller.navigationController pushViewController:composeVC animated:YES];
//        [controller presentViewController:composeVC animated:YES completion:nil];
    } @catch (NSException *exception){
        
       // NSLog(@"没有安装");
        success = NO;
        
    } @finally {
        
        if (completion) {
            completion(self,success);
        }
    }
    
    return success;
}

#pragma mark - Private
- (NSString *)serviceTypeWithType:(TSShareHelperShareType)type{
    //这个方法不再进行校验,传入就不等于0.这里做一个转换
    NSString * serviceType;
    if ( type!= 0){
        switch (type){
            case TSShareHelperShareTypeWeChat:
                
                //com.tencent.xin.sharetimeline
                serviceType = @"com.tencent.xin.sharetimeline";
                break;
            case TSShareHelperShareTypeQQ:
                serviceType = @"com.tencent.mqq.ShareExtension";
                break;
            case TSShareHelperShareTypeSina:
                if(@available(iOS 11.0, *))
                {
                   serviceType = SLServiceTypeSinaWeibo;
//                    NSLog(@"%@",SLServiceTypeSinaWeibo);
                }else {
                    //com.apple.share.SinaWeibo.post
                    serviceType = @"com.apple.share.SinaWeibo.post";
                }
                
                break;
            default:
                break;
        }
    }
    return serviceType;
}



@end