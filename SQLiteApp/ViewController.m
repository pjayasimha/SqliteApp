//
//  ViewController.m
//  SQLiteApp
//
//  Created by Jayasimha on 04/02/15.
//  Copyright (c) 2015 Jayasimha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *destpath;
}

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *strpath=[[NSBundle mainBundle]pathForResource:@"StudentDB" ofType:@"sqlite"];
    
    NSLog(@"strpath ==%@",strpath);
    
    NSArray *arrdocu=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    destpath=[[NSString alloc]initWithFormat:@"%@StudentDB.sqlite",[arrdocu objectAtIndex:0]];
    
    NSLog(@"destpath == %@",destpath);
    
    NSFileManager *manager=[[NSFileManager alloc]init];
    NSError *err;
    
    [manager copyItemAtPath:strpath toPath:destpath error:&err];
    
    if ([manager fileExistsAtPath:destpath]==YES) {
        
        NSLog(@"sucess");
        
    }else{
        
        NSLog(@"fail");
    }
    

    [self getValues];
    
    //[ self addvalues];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)getValues
{
    
    sqlite3_stmt *stmt;
    
    
    if (sqlite3_open([destpath UTF8String], &(databse))==SQLITE_OK) {
        
        NSString *strquery=[NSString stringWithFormat:@"select *from student"];
        
        if (sqlite3_prepare_v2(databse, [strquery UTF8String], -1, &stmt, nil)==SQLITE_OK) {
            
            
            while (sqlite3_step(stmt)==SQLITE_ROW) {
                
                int sid=sqlite3_column_int(stmt, 0);
                
                NSString *stdname=[NSString stringWithUTF8String:(char *) sqlite3_column_text(stmt, 1)];
                                    
                NSString *stdaddres=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];

                                      NSLog(@"id is == %d",sid);
                                      NSLog(@"name is == %@",stdname);
                                      NSLog(@"id is == %@",stdaddres);
                
                
            }
            
        }
        
        
        
    }
    
}

-(void)addvalues{
    
    sqlite3_stmt *stmt;
    
    
    if (sqlite3_open([destpath UTF8String], &(databse))==SQLITE_OK) {
        
        NSString *strquery=[NSString stringWithFormat:@"insert into student values (4,'vijay','uk')"];
        
        if (sqlite3_prepare_v2(databse, [strquery UTF8String], -1, &stmt, nil)==SQLITE_OK) {
            
            
            if (sqlite3_step(stmt) == SQLITE_DONE)
            {
                NSLog(@" success %d",sqlite3_step(stmt));
            } else
            {
                NSLog(@" fail %d",sqlite3_step(stmt));
            }
            sqlite3_finalize(stmt);
        }
    
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
