//
//  FASPhotoModel.h
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FASPhotoModel : NSObject

@property (nonatomic, nonnull) NSString *photoId;
@property (nonatomic, nonnull) NSString *secret;
@property (nonatomic, nonnull) NSString *server;
@property (nonatomic, nonnull) NSString *farm;

@end
