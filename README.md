# Blog

## Ghost CMS made static

It's using beauty of Ghost engine to create and manage post, and export as static website for deploy in github pages

supported command:
- `./server.sh start` to turn on the Ghost engine 
- `./server.sh stop` to turn off the Ghost engine
- `./server.sh deploy` to export blog as static website and place in ./gh-pages directory

to manage blog, visit `http://localhost:2368/ghost`

`git worktree add gh-pages gh-pages`