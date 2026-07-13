{ pkgs, config, lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Nicholas Tay";
      user.email = "nick@windblume.net";
      alias = {
	p = "push";
	pu = "push -u";
	puo = ''!git push -u origin "$(git branch --show-current)"'';
	pf = "push --force-with-lease";
	pff = "push -f";
	# pushGerrit";
	pG = ''!git push origin HEAD:refs/for/"$(git master)"'';
	pl = "pull --recurse-submodules";
	pL = "pull";
	# fetch and reset hard into head";
	plR = ''!git fetch origin "$(git rev-parse --abbrev-ref HEAD)" && git reset --hard origin/"$(git rev-parse --abbrev-ref HEAD)"'';
	f = "fetch";
	fo = "fetch origin";
	s = "status";
	su = "status --untracked-files=normal";
	sU = "status -u";
	st = "stash";
	stm = "stash -m";
	stp = "stash pop";
	stpp = ''!git stash pop "$(git stash list | fzf | cut -d ':' -f 1)"'';
	stl = "stash list";
	stD = "stash drop";
	sts = ''!git stash show -p stash@{$1} #'';
	stss = ''!git stash show -p "$(git stash list | fzf | cut -d ':' -f 1)"'';
	r = "remote";
	rv = "remote -v";
	rb = "rebase";
	rbi = "rebase -i";
	rbm = ''!git rebase "$(git master)"'';
	a = "add";
	aa = "add .";
	ap = "add -p";
	co = "checkout";
	coo = ''!git checkout "$(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf)"'';
	cob = "checkout -b";
	com = ''!git checkout "$(git master)"'';
	cot = "checkout --track";
	cott = ''!git checkout --track "$(git for-each-ref --format='%(refname:short)' refs/remotes/ | fzf)"'';
	c = "commit";
	ca = "commit -a";
	cm = "commit -m";
	cam = "commit -a -m";
	camd = "commit --amend";
        master = ''!git symbolic-ref refs/remotes/origin/HEAD | sed 's|^refs/remotes/origin/||' '';
	d = "diff";
	dc = "diff --cached";
	l = "log";
	m = "merge";
	mm = ''!git merge "$(git master)"'';
	b = "branch";
	br = "branch --remote";
	bD = "branch -D";
	bDD = ''!git branch -D "$(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf)"'';
	chp = "cherry-pick";
	cl = "clone --recurse-submodules";
	cll = "clone";
	bs = "bisect";
	bsg = "bisect good";
	bsb = "bisect bad";
	bss = "bisect skip";
      };

      init.defaultBranch = "master";
      pull.rebase = true;

      commit.verbose = true;

      difftool.prompt = false;
      diff.tool = "nvimdiff";
      difftool."nvimdiff".cmd = ''nvim -d \"$LOCAL\" \"$REMOTE\"'';
    };
  };
}
