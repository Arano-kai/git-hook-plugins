# git-hook-plugins
Implementing plugin-like version controlled hook system for git.

Use
----------
1. a) Clone this repo and copy content to subfolder of Your repo (eg: `<reponame>/utils/git-hook-plugins`) or
1. b) Connect this repo as git submodule.
2. Create folder `git-hooks`  next to it (eg: `<reponame>/utils/git-hooks`), then in it:
  * Make subfolder: `<preferred-hook-name>.d`.
  * Drop Your hook scripts to that subfolder (dont't forget set executable flag).
3. Add those files to git.
4. Run `hook-wrapper` directly.
  * This will call setup menu with further instructions.

That's it! From now, every time hook is invoked, scripts in `<preferred-hook-name>.d` will be executed in sorted order.

Add hooks
----------------
* Do steps 2-4 from 'Use' section.

Delete hooks
------------
* Run `hook-wrapper` directly to call setup menu.
* Optionally, remove stalled hooks from `git-hooks`.

Moved `.git` to another place?
------------------------------
* Run `hook-wrapper` directly to call setup menu.

Customize
---------
Done by modifying vars in Opts zone of `hook-wrapper` (will be changed in future).
Currently avialible:
* Name and location of hooks subfolger (`git-hooks`).
* Wrapper message prefix (`TAG`)
