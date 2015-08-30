//
//  ViewController.m
//  NSFileManager
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self checkFileExists];
    
    [self listAllDocument];
    
    [self recursiveDocumentFiles];
    
    [self createDocument];
    
    [self deleteDocument];
}

#pragma mark -  确定文件是否存在
- (void)checkFileExists
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"file.txt"];
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    
    NSLog(@"%d",fileExists);

}


#pragma  mark - 列出文件里面的所有目录
- (void)listAllDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        // 在目录中枚举 .png 文件
    }

}

#pragma mark - 在目录中递归地遍历文件
- (void)recursiveDocumentFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:bundleURL
                                          includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        errorHandler:^BOOL(NSURL *url, NSError *error)
    {
        if (error) {
            NSLog(@"[Error] %@ (%@)", error, url);
            return NO;
        }
        
        return YES;
    }];
    
    NSMutableArray *mutableFileURLs = [NSMutableArray array];
    for (NSURL *fileURL in enumerator) {
        NSString *filename;
        [fileURL getResourceValue:&filename forKey:NSURLNameKey error:nil];
        
        NSNumber *isDirectory;
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        // Skip directories with '_' prefix, for example
        if ([filename hasPrefix:@"_"] && [isDirectory boolValue]) {
            [enumerator skipDescendants];
            continue;
        }
        
        if (![isDirectory boolValue]) {
            [mutableFileURLs addObject:fileURL];
        }
    }

}

#pragma mark - 创建目录
- (void)createDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imagesPath = [documentsPath stringByAppendingPathComponent:@"images"];
    if (![fileManager fileExistsAtPath:imagesPath]) {
        [fileManager createDirectoryAtPath:imagesPath withIntermediateDirectories:NO attributes:nil error:nil];
    };
}

#pragma mark - 删除目录
- (void)deleteDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSError *error = nil;
    
    if (![fileManager removeItemAtPath:filePath error:&error]) {
        NSLog(@"[Error] %@ (%@)", error, filePath);
    }

}

#pragma mark - 删除文件的创建日期
- (void)deleteFileCreateDate
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"Document.pages"];
    
    NSDate *creationDate = nil;
    if ([fileManager fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:nil];
        creationDate = attributes[NSFileCreationDate];
    }

}

//文件属性的键
//NSFileAppendOnly: 文件是否只读
//NSFileBusy: 文件是否繁忙
//NSFileCreationDate: 文件创建日期
//NSFileOwnerAccountName: 文件所有者的名字
//NSFileGroupOwnerAccountName: 文件所有组的名字
//NSFileDeviceIdentifier: 文件所在驱动器的标示符
//NSFileExtensionHidden: 文件后缀是否隐藏
//NSFileGroupOwnerAccountID: 文件所有组的group ID
//NSFileHFSCreatorCode: 文件的HFS创建者的代码
//NSFileHFSTypeCode: 文件的HFS类型代码
//NSFileImmutable: 文件是否可以改变
//NSFileModificationDate: 文件修改日期
//NSFileOwnerAccountID: 文件所有者的ID
//NSFilePosixPermissions: 文件的Posix权限
//NSFileReferenceCount: 文件的链接数量
//NSFileSize: 文件的字节
//NSFileSystemFileNumber: 文件在文件系统的文件数量
//NSFileType: 文件类型
//NSDirectoryEnumerationSkipsSubdirectoryDescendants: 浅层的枚举，不会枚举子目录
//NSDirectoryEnumerationSkipsPackageDescendants: 不会扫描pakages的内容
//NSDirectoryEnumerationSkipsHiddenFile: 不会扫描隐藏文件


//NSFileManagerDelegate
//
//NSFileManager 可以设置一个 <NSFileManagerDelegate> protocol 来确认是否要进行特定的文件操作。它允许进行一些业务逻辑，比如保护一些文件删除，在 Controller 中删除一些元素
//
//NSFileManagerDelegate里面有四个方法，每个按照path变化
//
//-fileManager:shouldMoveItemAtURL:toURL:
//-fileManager:shouldCopyItemAtURL:toURL:
//-fileManager:shouldRemoveItemAtURL:
//-fileManager:shouldLinkItemAtURL:toURL:

//如果你想用 alloc init 初始化你自己的 NSFileManager 来取代shared实例，那就要用它了，就像文档说的
//
//如果你使用一个delegate 来接受移动，拷贝，涉案出，以及链接的操作，你需要创建一个独一无二的实例，将delegate绑定到你的实例中，用这个fielmanager开始你的操作
//
//
//NSFileManager *fileManager = [[NSFileManager alloc] init];
//fileManager.delegate = delegate;
//
//NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
//NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
//                               includingPropertiesForKeys:@[]
//                                                  options:NSDirectoryEnumerationSkipsHiddenFiles
//                                                    error:nil];
//
//for (NSString *filePath in contents) {
//    [fileManager removeItemAtPath:filePath error:nil];
//}
//
//CustomFileManagerDelegate.m
//Objective-C
//
//#pragma mark - NSFileManagerDelegate
//
//- (BOOL)fileManager:(NSFileManager *)fileManager
//shouldRemoveItemAtURL:(NSURL *)URL
//{
//    return ![[[URL lastPathComponent] pathExtension] isEqualToString:@"pdf"];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
