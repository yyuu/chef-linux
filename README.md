# chef-linux

Configures Linux kernel parameters

## Supported Platforms

* Debian GNU/Linux
* Ubuntu Linux

## Examples

Disable Transparent Huge Page Compaction.

```rb
linux_transparent_hugepage "Disable Transparent Hugepage Compaction" do
  defrag "never"
end
```

Change the I/O scheduler of `/dev/sdb` to `noop`.

```rb
linux_io_scheduler "/dev/sdb" do
  block_device "/dev/sdb"
  scheduler "noop"
end
```

## License and Authors

Copyright 2015 Yamashita, Yuu (yuu@treasure-data.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
