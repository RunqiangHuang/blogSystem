# blogSystem
SSH的课程设计。一个简易的博客系统<br>
博客页面利用了一个网上的模板搭建而成，后台管理的页面主要利用layUI + JQuery。部分功能用到了ajax
<br>
后端采用strut2,spring,hibernate搭建而成。没有利用maven管理jar包
<hr>
这个简易博客系统是为了方便自己对博客的管理，可以在后台管理界面管理自己写过的文章，对文章进行分类，也可以通过此系统来管理读者对文章的评论以及对博主的留言。当然，后台管理界面也可以很好的对个人信息进行更新维护。
用户可以在博客前台页面很方便的根据分类查找文章，并对文章进行评论，也可以进入留言板，向博主提建议。
<hr>
# bug
+ 在发表文章时，如果是用网上复制的内容，直接发表的话，发表是可以成功，但是数据回显会失败，原因是复制的空行没有被转换成&#60;br&#62;标签，导致回显时js报错
+ 发表/修改草稿、正文是共用一个页面，而设计的时候他们没有继承的关系，导致在一个页面上用2个实体类出现了bug。因为缺少某些属性，导致jstl不能正常使用，因此后面对一些属性类加了一些没用的get方法，这样虽然能实现功能，但是控制台有错误报出
# 不足
+ 用户的功能比较少，缺少交互的功能
+ 评论显示没有楼中楼。
+ 没有用到权限控制。没有拦截非法访问。
+ 文章只能一个分类。不能有多个分类
+ 有些功能完成后全局刷新页面，没利用ajax局部刷新。浪费了网络资源
<hr>
# 部分功能截图 
+ 请参照photos目录
