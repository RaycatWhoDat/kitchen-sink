use v6;

my $file = "24-hour-clock.raku".IO.slurp;
my $match = $file ~~ / "return %formattedTime;" /;

spurt "24-hour-clock-reformat.raku", $match.replace-with: q:to/END/;
say %formattedTime;
return %formattedTime;
END

# (let ((results-buffer (generate-new-buffer "*Reformat Results*"))) 
#  (with-current-buffer results-buffer
#   (insert-file-contents "24-hour-clock-reformat.raku")
#   (raku-mode)
#   (goto-char (point-min))
#   (set-mark (point-max))
#   (indent-for-tab-command)
#   (switch-to-buffer-other-window results-buffer)
#   (keyboard-quit)))
