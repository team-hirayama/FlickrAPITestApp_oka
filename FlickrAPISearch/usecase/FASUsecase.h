//
//  FASUsecase.h
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FASPhotoModel.h"

@protocol LoadPhotosUsecase <NSObject>

- (void)loadPhotoWithData:(NSArray<FASPhotoModel *> *)dataSource;
- (void)loadPhotoWithNoData;

@end

@interface FASUsecase : NSObject

@property (weak, nonatomic) id<LoadPhotosUsecase> usecase;

- (void)requestWithSearchWord:(NSString *)word Page:(NSInteger)page;

@end
