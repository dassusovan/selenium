// Licensed to the Software Freedom Conservancy (SFC) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The SFC licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

package org.openqa.selenium.netty.server;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http2.HttpConversionUtil;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Logger;

import org.openqa.selenium.grid.web.ErrorHandler;
import org.openqa.selenium.internal.Require;
import org.openqa.selenium.remote.http.HttpHandler;
import org.openqa.selenium.remote.http.HttpRequest;
import org.openqa.selenium.remote.http.HttpResponse;

class SeleniumHttp2Handler extends SimpleChannelInboundHandler<HttpRequest> {

  private static final Logger LOG = Logger.getLogger(SeleniumHttp2Handler.class.getName());
  private static final ExecutorService EXECUTOR = Executors.newCachedThreadPool();
  private final HttpHandler seleniumHandler;
  private static final String STREAM_ID_HEADER =
      HttpConversionUtil.ExtensionHeaderNames.STREAM_ID.text().toString();

  public SeleniumHttp2Handler(HttpHandler seleniumHandler) {
    super(HttpRequest.class);
    this.seleniumHandler = Require.nonNull("HTTP handler", seleniumHandler);
  }

  @Override
  protected void channelRead0(ChannelHandlerContext ctx, HttpRequest msg) {
    EXECUTOR.submit(() -> {
      HttpResponse res;
      String streamId = msg.getHeader(STREAM_ID_HEADER);
      try {
        res = seleniumHandler.execute(msg);
      } catch (Throwable e) {
        res = new ErrorHandler(e).execute(msg);
      }
      res.addHeader(STREAM_ID_HEADER, streamId);
      ctx.writeAndFlush(res);
    });
  }

}
