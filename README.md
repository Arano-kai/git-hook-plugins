# git-hook-plugins
Implementing plugin-like version controlled hook system for git.

Use
----------
1. Clone this repo
2. Copy content to subfolder of Your repo
3. In hooks subfolder:
  * Make softlink: `ln -s hook-wrapper <preferred-hook-name>`
  * Make subfolder: `mkdir <preferred-hook-name>.d`
  * Drop Your hook scripts to that subfolder
    * Dont't forget set executable flag
4. Add those files to git
5. Run `setup-hooks.sh` helper script
  * This will kindly install hooks, not overwriting existing ones

That's it! From now, every time hook is invoked, scripts in `<preferred-hook-name>.d` will be executed in sorted order.

Add hooks
----------------
* Do steps 3-5 from 'Use' section

Delete hooks
------------
* Remove `<preferred-hook-name>.d` from Your repo and remove `<preferred-hook-name>` from repo and `.git/hooks/`
  * It is enough to remove the `<preferred-hook-name>.d` directory, but it will be a little spam in logs...

Moved `.git` to another place?
------------------------------
* Remove `hook-wrapper` from `.git/hooks/` and run `setup-hooks.sh` again
