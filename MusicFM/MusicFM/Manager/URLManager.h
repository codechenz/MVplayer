//
//  URLManager.h
//  MusicFM
//
//  Created by 李光耀 on 16/1/7.
//  Copyright © 2016年 LWZ. All rights reserved.
//

#ifndef URLManager_h
#define URLManager_h

#warning MV接口
// Device-Id 的值
#define kMVid @"1e02b30531602317853a99c0cb2c5661"
// Device-V 的值
#define kMVDv @"aVBob25lIE9TXzkuMV8xMjQyKjIyMDhfMTAwMDAxMDAwX2lQaG9uZTcsMQ=="
// App-Id 的值
#define kMVApp @"10101025"
// MV首播
#define kMVMv @"http://mapi.yinyuetai.com/video/list.json?D-A=0"
//艺人资料
#define kMVYR @"http://mapi.yinyuetai.com/artist/show.json?D-A=0"
// mv推荐
#define kMVMMV @"http://mapi.yinyuetai.com/video/show.json?D-A=0"
//艺人资料刷新MV
#define kMVYRMV @"http://mapi.yinyuetai.com/video/list_by_artist.json?D-A=0"
//MV评论
#define kMVPl @"http://mapi.yinyuetai.com/video/comment/list.json?D-A=0"
//搜索界面推荐
#define kMVSearchRecommend @"http://mapi.yinyuetai.com/search/top_keyword.json"
//搜索请求
#define kMVSearch @"http://mapi.yinyuetai.com/search/video.json?D-A=0"
//播fans音乐榜
#define kMVMusicPH @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?"
#define kMVMusicGroupArray @[@"365905/365918/469202/469231", @"365905/365918/469202/471150", @"365905/365918/469202/472731", @"365905/365918/469202/614523", @"365905/365918/469202/2782650", @"365905/365918/469202/2784353"]

#define kMVmusic @"http://a.vip.migu.cn/rdp2/v5.5/ranklist.do?groupcode=rank&ua=Iphone_Sst&version=4.243&pageno=1"

//歌词
#define kMVLrc @"http://a.vip.migu.cn/rdp2/v5.5/lrcinfo.do?"

#define kMVSearchKeyWord @"http://mapi.yinyuetai.com/search/suggest.json?D-A=0"
#warning MV接口结束

//------------------------------------------
#warning FM【接口 start】
#define kFMAllURL @"http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=and-d3&device=android&includeActivity=true&includeSpecial=true&scale=2&version=4.3.38.2"
#define kFMDetailsURL @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/%@?device=iphone&key=%@&pageId=1&pageSize=40"
#define kFMHostExURL @"http://mobile.ximalaya.com/mobile/others/ca/track/%@/1/30?device=iPhone"

#warning FM【接口end】
//------------------------------------------

#define kMusicPage_Music @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/469231&pageno=1&ua=Iphone_Sst&version=4.2421"
#define kMusicPage_Hot @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/471150&pageno=1&ua=Iphone_Sst&version=4.2421"
#define kMusicPage_KTV @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/472731&pageno=1&ua=Iphone_Sst&version=4.2421"
#define kMusicPage_OnLine @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/614523&pageno=1&ua=Iphone_Sst&version=4.2421"
#define kMusicPage_TV @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/2782650&pageno=1&ua=Iphone_Sst&version=4.2421"
#define kMusicPage_Mine @"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/2784353&pageno=1&ua=Iphone_Sst&version=4.2421"










#endif /* URLManager_h */
