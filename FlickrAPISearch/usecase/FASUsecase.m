//
//  FASUsecase.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASAPIClient.h"
#import "FASUsecase.h"


@implementation FASUsecase

- (void)requestWithSearchWord:(NSString *)word Page:(NSInteger)page {
    [FASAPIClient getPhotoDataWithWord:word
                                  Page:page
                              Callback:^(NSArray<FASPhotoModel *> *results) {
                                  if (results.count) {
                                      if ([self.usecase respondsToSelector:@selector(loadPhotoWithData:)]) {
                                          [self.usecase loadPhotoWithData:results];
                                      }
                                  } else {
                                      if ([self.usecase respondsToSelector:@selector(loadPhotoWithNoData)]) {
                                          [self.usecase loadPhotoWithNoData];
                                      }
                                  }
                              }];
}

@end
