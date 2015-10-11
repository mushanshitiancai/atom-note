# 开发日志
## 背景
一路过来用了很多笔记软件，尝试过为知笔记，印象笔记，有道云笔记，Zim，了解过vim-wiki，org-mode，TiddlyWiki，gollum，mdwiki等。

实际的使用上，从高中开始使用为知笔记，一直到大学毕业后，无意中了解到Zim，使用Zim+快盘一段时间，Zim虽然看起来简陋，实际上还是很强大的，也可以使用git等版本控制工具作为后台。

这么多笔记软件，用着总是感觉不顺手，比如比较诟病的一点，就是笔记软件的编辑功能，像为知笔记，有道云笔记，印象笔记，这三个应该算是现在最流行的云笔记了。从普通用户的视角上来看，编辑功能也是够用了，富文本编辑器，可以插入图片等附近。但是作为程序员，这样就远远不够了，想用markdown？印象笔记和有道云笔记就跪了，为知笔记虽然支持，但是很不完美。印象笔记虽然有类似马克飞象这种第三方编辑器入口，提供了很好的markdown编辑体验，但是不是原生支持，就是感觉不爽。

Zim底子里是wiki。保存的文件也都是纯文本。他的半所见即所得的编辑器虽然简单但也够用了。日记功能，TODO功能都很实用，也有一些强大插件。比较符合心目中的"程序员的PKM"。

一直就想写一个至少自己用着爽的笔记软件，也的确，每个人有不同的喜欢，如果真的要做到最符合自己心意，也只能自己写一个了。加上换了mac后，Zim没有mac版，所以着手开发这个atom-note。

为什么选择atom插件这种形式呢。上面也说了，编辑的舒适程度，我是比较看重的，自己写一个编辑器，工作量太大，所以想依附于现有编辑器，改写代码或者是以插件形式。Emacs和vim我学不会，所以合适的候选编辑器就剩下sublime和atom了。其实从编辑器本身来看，sublime现在还是比atom好用的。但是了解过后，不得不说，atom就是未来编辑器该有的模样了。设计很先进，一整套的HTML5+nodejs技术。扩展性很强，因为就是一个浏览器啊。

所以，atom-note。

## 规划
### v0.0.1（2015年10月1日~）
完成这个版本后，atom-note大体上可以使用，我将会把插件放到atom插件仓库中
- [ ] 设计笔记的存储格式
- [ ] 新建笔记本
- [ ] 新建笔记
- [ ] 插入笔记链接
- [x] 插入剪贴板图片（可以使用快捷键插入剪贴板中的图片，图片会被放到当前笔记对应的附件目录中）
- [ ] 快捷键开关TODO
- [ ] 快捷键打开今日日记
- [ ] 笔记本树视图（atom-note-tree-view，显示笔记的树形结构，而不是文件夹的树形结构）

### v0.0.2
- [ ] 删除图片（图片被删除时，询问是否保留附件目录中的图片文件）

### TODO
- 日历界面
- 快速唤出收集箱
- 标题折叠
- 锚点

## 日志
### ~2015年10月07日
国庆这几天，效率低得不行。大致了解了atom插件的编写，还有spec测试用例的写法，atom这个测试集成设计的也很好。测试过的代码就是放心。

NotebookCommand
- [x] open-today-journal

NotebookUtil
- [x] isLegalNotebook
- [x] getActiveNotebookPath
- [x] getJournalPath
- [x] openJournal

### 2015年10月10日~
- [x] NoteUtil::initNote
- [x] NoteUtil::generateNoteHeader

初始化文件头，需要使用YAML [The Official YAML Web Site](http://yaml.org/)

```
npm install js-yaml
```

- [x] NoteUtil::getActiveNoteFolder
- [x] NoteUtil::ensureActiveNoteFolder
- [x] NoteUtil::insert-image
- [x] Util::getPrefixText
- [x] NotebookCommand::insert-image
- [x] 配置insert-image命令到ctrl+v上（TODO 这个在win上就有问题了）
- [x] 如果配置到系统默认的粘贴快捷键上，在剪贴板中没有图片时，需要返回默认粘贴行为，如何做到？
- [x] atom如何为不同的系统设置不同快捷键？
- [x] 如果用户在粘贴图片时没有选中文本作为图片的标题，则使用光标所在行的文本作为标题（关键在于判断是否是合法文件名）
- [x] 学习snippets.coffee
- [ ] 分离检查是否进入插入图片代码与插入图片代码
- [ ] 对于选中作为图片标题的文本，检查其合法性
- [ ] 在readme中添加图片两种插入方式的feature

### atom如何为不同的系统设置不同快捷键？
atom编辑器在body标签上，标明了是那种平台：

```
<body tabindex="-1" class="platform-darwin is-blurred">
  ...
</body>
```

所以可以这么绑定：

```
".platform-win32 atom-text-editor[data-grammar~='gfm']":
  ...
```

### 如果覆盖了默认快捷键，如果在插件代码解释后，会继续执行其他绑定，如何中断？
使用`e.abortKeyBinding()`

```
editor.command 'snippets:expand', (e) =>
  if @cursorFollowsValidPrefix()
    @expandSnippet()
  else
    e.abortKeyBinding()
```

## 问题
- 使用electron的剪贴板模块，保存截图到文件中，分辨率会比较低，这是为什么？

## 关键词
- Git Large File Storage v1.0

## temp

```
"activationCommands": {
  "atom-text-editor": [
    "atom-note:insert-list-new-line",
    "atom-note:test",
    "atom-note:insert-image"
  ]
},
```
