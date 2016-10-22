//
//  FASAPIClient.h
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FASPhotoModel.h"

@interface FASAPIClient : NSObject

typedef void (^APICallback)(NSArray<FASPhotoModel *> *results);
+ (void)getPhotoDataWithWord:(NSString *)word Page:(NSInteger)page Callback:(APICallback)callback;

@end
