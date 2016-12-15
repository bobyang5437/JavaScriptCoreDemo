//
//  MyObject.h
//  jsTest
//
//  Created by yang on 2016/12/13.
//  Copyright © 2016年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestCore <JSExport>

JSExportAs(customLog, - (void)printLog:(NSString *)str);

@end

@interface MyObject : NSObject<TestCore>

@end
