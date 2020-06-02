use v6;
use NativeCall;

class NULL is repr("CPointer") { }

class Janet is repr("CUnion") {
    has uint64 $.u64;
    has long $.number;
    has int32 $.integer;
    has Str $.pointer is rw;
    has Str $.cpointer is rw;
}

class JanetKV is repr("CStruct") {
    has Janet $.key;
    has Janet $.value;
}

class JanetGCObject is repr("CStruct") {
    has int32 $.flags;
    has JanetGCObject $.next is rw;
}

class JanetTable is repr("CStruct") {
    has JanetGCObject $.gc;
    has int32 $.count;
    has int32 $.capacity;
    has int32 $.deleted;
    has JanetKV $!data;
    has JanetTable $!proto;
}

sub janet_init() returns Str is native("janet") { * };
sub janet_core_env(JanetTable(NULL) $replacements) returns JanetTable is native("janet") { * };
sub janet_dostring(JanetTable $env, Str $string, Str $sourcePath, Janet $out) returns Str is native("janet") { * };
sub janet_deinit() returns Str is native("janet") { * };

sub MAIN() {
    say "Here we go...";

    my $janetScript = slurp "test-script.janet";

    janet_init;
    my JanetTable $env = janet_core_env(NULL);
    janet_dostring($env, $janetScript, "main", NULL);
    janet_deinit;
}
