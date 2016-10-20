# synology_ds_get
Alternative to Synology Download Station App (ds get) 


Synology Developer Web API

Login
/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=admin&passwd=12345&session=DownloadStation&format=cookie
OR
/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=admin&passwd=12345&session=DownloadStation&format=sid

Logout
/webapi/auth.cgi?api=SYNO.API.Auth&version=1&method=logout&session=DownloadStation

Info for download task
/webapi/query.cgi?api=SYNO.API.Info&version=1&method=query&query=SYNO.API.Auth,SYNO.DownloadStation.Task

Request Download API
/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=list

Create Task
POST /webapi/DownloadStation/task.cgi

api=SYNO.DownloadStation.Task
&version=1
&method=create
&uri=ftps://192.0.0.1:21/test/test.zip
&username=admin
&password=123