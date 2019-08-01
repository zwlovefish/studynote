# Markdown TOC
在markdown文件中根据#title 生成目录，注意# 这里不能有中文字符
在首选项---->Package settings---->markdownToc---->Settings User中写入:
```
{
  "defaults": {
    "autolink": true,
    "bracket": "round",
    "uri_encoding": false
  },
  "id_replacements": [
    {
      "pattern": "\\s+",
      "replacement": "-"
    },
    {
      "pattern": "&lt;|&gt;|&amp;|&apos;|&quot;|&#60;|&#62;|&#38;|&#39;|&#34;|!|#|$|&|'|\\(|\\)|\\*|\\+|,|/|:|;|=|_|\\?|@|\\[|\\]|`|\"|\\.|<|>|{|}|™|®|©",
      "replacement": ""
    }
  ]
}
```

# Markdown Editing
支持markdown语法编辑的插件

# OmniMarkupPreviewer
支持同时编辑markdown文件，边在浏览器中浏览效果。
在首选项---->Package settings---->OmniMarkupPreviewer---->Settings Default中
将最后一行改为
"extensions": ["tables","fenced_code", "codehilite"]

