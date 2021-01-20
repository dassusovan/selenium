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

package org.openqa.selenium.grid.data;

import java.util.HashMap;
import java.util.Map;

import static java.util.Collections.unmodifiableMap;

public class PlatformInfo {
  private String platform;
  private Integer count;
  private Map<String, BrowserVersionInfo> browserVersionMap;

  public PlatformInfo(String platform) {
    this.platform = platform;
    this.count = 0;
    this.browserVersionMap = new HashMap<>();
  }

  public String getPlatform() {
    return platform;
  }

  public Integer getCount() {
    return count;
  }

  public void setCount(Integer count) {
    this.count = count;
  }

  public Map<String, BrowserVersionInfo> getBrowserVersionMap() {
    return browserVersionMap;
  }

  private Map<String, Object> toJson() {
    Map<String, Object> toReturn = new HashMap<>();
    toReturn.put("platform", platform);
    toReturn.put("count", count);
    toReturn.put("browserVersions", browserVersionMap.values());
    return unmodifiableMap(toReturn);
  }
}
