//
//  WebUtils.m
//  DAZongDianPing
//
//  Created by wanglin on 15-3-30.
//  Copyright (c) 2015年 tarena. All rights reserved.
//
#import "JsonPaeser.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "WebUtils.h"
#define kAPP_KEY @"9470721701"
#define kAPP_SECRET @"2624927ba59f40d09772b7119bac989d"
@implementation WebUtils
+(void)requestBusinessAndCallback:(MyCallback)callback{
    
    NSString *path = @"http://api.dianping.com/v1/business/find_businesses";
    path = [WebUtils serializeURL:path params:@{@"city":@"北京"}];
//    NSLog(@"%@",path);
    

    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"%@",dic);
        NSArray *bussinesses = [JsonPaeser parseBussinessByDic:dic];
        callback(bussinesses);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    [op start];
    
    
}
+(void)requestBusinessWithParams:(NSDictionary *)params AndCallback:(MyCallback)callback{
    NSString *cityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
    
     NSMutableDictionary *allParams = [params mutableCopy];
    [allParams setObject:cityName forKey:@"city"];
     NSString *path = @"http://api.dianping.com/v1/business/find_businesses";
    path = [WebUtils serializeURL:path params:allParams];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *bus = [JsonPaeser parseBussinessByDic:dic];
        callback(bus);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
    [op start];
}

+(void)requestDealsWithParams:(NSDictionary *)params AndCallback:(MyCallback)callback{
    NSMutableDictionary *allParams = [params mutableCopy];
     [allParams setObject:@"北京" forKey:@"city"];
    NSString *path = @"http://api.dianping.com/v1/deal/find_deals";
    path = [WebUtils serializeURL:path params:allParams];
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *deals = [JsonPaeser parserDealbydic:dic];
        callback(deals);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"qingqiushipai");
    }];
    
    
    
    [op start];
    
    
    
    
    
    
    
    
    
}











+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
    NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
    if (params) {
        [paramsDic setValuesForKeysWithDictionary:params];
    }
    
    NSMutableString *signString = [NSMutableString stringWithString:kAPP_KEY];
    NSMutableString *paramsString = [NSMutableString stringWithFormat:@"appkey=%@", kAPP_KEY];
    NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
    for (NSString *key in sortedKeys) {
        [signString appendFormat:@"%@%@", key, [paramsDic objectForKey:key]];
        [paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
    }
    [signString appendString:kAPP_SECRET];
    unsigned char digest[20];
    NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        /* SHA-1 hash has been calculated and stored in 'digest'. */
        NSMutableString *digestString = [NSMutableString stringWithCapacity:20];
        for (int i=0; i<20; i++) {
            unsigned char aChar = digest[i];
            [digestString appendFormat:@"%02X", aChar];
        }
        [paramsString appendFormat:@"&sign=%@", [digestString uppercaseString]];
        return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    } else {
        return nil;
    }
}


+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        if ([elements count] <= 1) {
            return nil;
        }
        
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

+(void)requestStartInfoWithStartName:(NSString*)name AndCallback:(MyCallback)callback{
    NSString *path = [NSString stringWithFormat:@"http://web.juhe.cn:8080/video/v?appkey=f0e620e13cb28728e6a5f4cc5e0e9dfb&v=1.0&pname=com.tarena&keyword=%@",name];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        Star *s =[JsonPaeser parseStarByDic:dic];
        callback(s);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"qingqiushibai");
    }];
    
    
    [op start];
    
    
    
    
}

+(void)requestMoivesWithMoiveName:(NSString*)name AndCallback:(MyCallback)callback{
    
    NSString *path = [NSString stringWithFormat:@"http://web.juhe.cn:8080/video/v?appkey=f0e620e13cb28728e6a5f4cc5e0e9dfb&v=1.0&pname=com.tarena&keyword=%@",name];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:path]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:path] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *movies = [JsonPaeser parseMoviesByDic:dic];
        callback(movies);
    }];
    
    
    [task resume];
    
    
}

+(void)requestMoiveURLWithSourceID:(NSString*)SouceID AndCallback:(MyCallback)callback{
    
    NSString *path = [NSString stringWithFormat:@"http://web.juhe.cn:8080/video/vs?appkey=f0e620e13cb28728e6a5f4cc5e0e9dfb&v=1.0&pname=com.tarena&id=%@",SouceID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
                                    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *url = [JsonPaeser parseMovieURLByDic:dic];
        callback(url);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
    [op start];
    
    
    
}


@end
