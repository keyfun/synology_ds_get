//
//  DownloadTaskResponse.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

/*
 json = ["data": {
 offset = 0;
 tasks =     (
 {
 id = "dbid_399";
 size = 229054648;
 status = finished;
 title = "[HYSUB]Magic-Kyun! Renaissance[02][BIG5_MP4][1280X720].mp4";
 type = bt;
 username = admin;
 },
 {
 id = "dbid_400";
 size = 256257322;
 status = finished;
 title = "[HYSUB]Magic-Kyun! Renaissance[03][BIG5_MP4][1280X720].mp4";
 type = bt;
 username = admin;
 }
 );
 total = 2;
 }, "success": 1]
*/

class TaskListResponse {
    
    var offset:Int
    var tasks:Array<Task>
    var total:Int
    var success:Int
    
    init(json: [String:Any]) {
        
    }
}
