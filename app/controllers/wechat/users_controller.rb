module Wechat
  class UsersController < ApplicationController
    def callback
      rsp = wechat_gate_config.oauth2_access_token(params[:code]) ##通过code获取微信的access_token
      user_open_id = rsp['openid'] ##获取openid

      user_data = wechat_gate_config.oauth2_user(rsp['access_token'], user_open_id)  ##微信公众账号通过Access Token向服务器请求用户信息(昵称...)

      Rails.logger.info "WECHAT: OAuth2 user: #{user_data},state: #{params[:state]}"
      
      render plain: user_data
    end
  end
end