# License requirements for Apstra Hub Configuration Packs

All Apstra Hub Configuration Packs must use the MIT license (SPDX-License-Identifier: MIT)

```
MIT License

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Both the CI workflows in the example pack repository and the Apstra Hub release ingest
process validate the license by taking the SHA-256 hash of the `LICENSE` or `LICENSE.txt`
file at the root of the repository after eliminating the `Copyright` line(s). The expected
hash result is `12aff42bbcb24fe64b0ca46950fb0197dc82386b2dcf24ee47cf0de627992d3d`.

The easiest way to add the license is to use the _Add file_ -> _+ Create new file_ feature
at the top of the repository root in the GitHub web UI. Type `LICENSE` in the filename box.
A _Choose a license template_ button will appear. Click it, select the MIT license, click 
_Review and submit_ and then _Commit changes_.
