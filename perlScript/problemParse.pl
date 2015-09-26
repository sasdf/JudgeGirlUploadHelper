#!/usr/bin/perl
use List::MoreUtils qw(uniq);

my $str="";
while( $_=<> ){
    chomp;
    $str.=$_;
}

$str =~ /<h2 id="task\-description">(.*)<h2>Submit<\/h2>/;
$str = "===".$1;
$str =~ s/<(\/{0,1})code[^>]*>/[\1code]/g;
$str =~ s/<h2/\n\n===<h2/g;
$str =~ s/<\/h2>/===\n<\/h2>/g;
$str =~ s/<[^>]*>//g;
$str =~ s/\[\/{0,1}code\]\[\/{0,1}code\]/\n/g;
$str =~ s/\ *\[code\]/\n/g;
$str =~ s/\[\/code\]\ */\n/g;
@mathjax = ($str =~ m/\$[^\$]*\$/g);
for my $i (uniq @mathjax){
    $sub = substr $i,1,-1;
    $sub =~ s/\\le /<=/g;
    $sub =~ s/\\lt /</g;
    $sub =~ s/\\ge />=/g;
    $sub =~ s/\\gt />/g;
    $sub =~ s/\\cdot / . /g;
    $ss = quotemeta $i;
    $str =~ s/$ss/$sub/g;
}
print $str."\n";
