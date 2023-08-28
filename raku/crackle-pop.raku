put ($_ %% 3 and $_ %% 5) ?? "CracklePop" !! ($_ %% 3) ?? "Crackle" !! ($_ %% 5) ?? "Pop" !! $_ for 1..100;
