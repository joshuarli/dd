# [dd](https://jrl.ninja/configs/dd)

arch linux daily driver desktop [configs](https://github.com/JoshuaRLi/dotfiles/tree/master/configs/dd)

```
wm + friends:   bspwm + sxhkd + rofi + dunst
bar:            polybar
term:           urxvt
fonts:          ttf-hack + ttf-font-awesome-4
shell:          zsh
```


## install

ymmv, but generally from a fresh arch install, `install-stage1.sh` in a tty as a sudo-enabled user, then in X, `install-stage2.sh` and reboot (or `kill xinit` then `startx` again).

**NOTE**: on every `startx`, you will need to manually run `polybar top` and `polybar bottom` either via `rofi` or background + disowning from a shell.
