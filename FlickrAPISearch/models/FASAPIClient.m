//
//  FASAPIClient.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASAPIClient.h"
#import "FASPhotoModel.h"

#import "XMLReader.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const FASApiKey = @"10ba93bbe49a6480d765ce486673954a";
static NSString *const FASRequestUrl = @"https://api.flickr.com/services/rest";

@implementation FASAPIClient

+ (void)getPhotoDataWithWord:(NSString *)word
                        Page:(NSInteger)page
                    Callback:(APICallback)callback {
    
    NSDictionary *parameter = @{@"method": @"flickr.photos.search",
                                @"api_key": FASApiKey,
                                @"text": word,
                                @"per_page": @"50",
                                @"page": @(page)};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = requestSerializer;
    
    [manager GET:FASRequestUrl
      parameters:parameter
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
             NSError *error = nil;
             NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:responseObject
                                                                options:XMLReaderOptionsProcessNamespaces
                                                                  error:&error];
             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:xmlDictionary
                                                                options:NSJSONWritingPrettyPrinted
                                                                  error:&error];
             NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:NSJSONReadingAllowFragments error:&error];
             NSMutableArray *dataSource = [NSMutableArray array];
             for (NSDictionary<NSString *, NSString *> *item in dic[@"rsp"][@"photos"][@"photo"]) {
                 FASPhotoModel *model = [FASPhotoModel new];
                 model.photoId = item[@"id"];
                 model.secret = item[@"secret"];
                 model.server = item[@"server"];
                 model.farm = item[@"farm"];
                 [dataSource addObject:model];
             }
             callback(dataSource);

         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             callback(nil);
         }];
}

@end
