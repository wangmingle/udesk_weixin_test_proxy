#微信测试环境支持第三方模式接入

##说明
1、代理服务器使用80端口，使用imdev.udeskmonkey.com进行测试（微信域名配置不支持端口）
2、现阶段只能一个测试服务器的转发，多服务器转发存在问题
    + 1、客户消息转发多台不方便定位问题，每个测试服务器消息处理配置不同
    + 2、微信对响应有要求，只能使用 proxy_pass等待处理结果
3、切换玩环境需要等10分钟左右，因为微信ticket推送是10分钟推一次，完成推送后才可以进行扫描授权

#部署
```bash
cap test_udeskb1 deploy

cap test_udeskb1 udesk:setup_nginx_file
cap test_udeskb1 udesk:nginx_reload
```

