#!/usr/bin/perl
use List::MoreUtils qw(uniq);

my $str="";
while( $_=<> ){
    chomp;
    $tmp=$_;
    $tmp =~ s/[\r\n]//sg;
    $str.=$tmp;
}

$str =~ /<div class="content">.*?<div.*?Status.*?<\/div>.*?<h2.*?>(.*)<h2>Submit<\/h2>/;
$str = "===".$1;
#$str =~ s/<(\/{0,1})code[^>]*>/[\1code]/g;
$str =~ s/<h2/[nElem]\n\n===<h2/g;
$str =~ s/<\/h2>/===\n[nElem]<\/h2>/g;
$str =~ s/<\/p>\n*\s*<p>/[nElem] [nElem]/g;
$str =~ s/(\n*\s*(<\/div>|<\/*pre>|<br\s*\/*>|<\/*p>))+/[nElem]/g;
$str =~ s/<li>/\n# <li>/g;
$str =~ s/<img/[nElem][ img ][nElem]<img/g;
$str =~ s/<[^\>]*?>//sg;
$str =~ s/(\[nElem\])+/\n/g;
$str =~ s/\&nbsp\;/ /g;
$str =~ s/\&lt\;/</g;
#$str =~ s/\[\/{0,1}code\]\[\/{0,1}code\]/\n/g;
#$str =~ s/\ *\[code\]/\n/g;
#$str =~ s/\[\/code\]\ */\n/g;
$str =~ s/\\\( /\$/g;
$str =~ s/ \\\)/\$/g;
@mathjax = ($str =~ m/\$[^\$]*\$/sg);
for my $i (uniq @mathjax){
    $sub = substr $i,1,-1;
    $sub =~ s/\\le/<=/g;
    $sub =~ s/\\lt/</g;
    $sub =~ s/\\ge/>=/g;
    $sub =~ s/\\gt/>/g;
    $sub =~ s/\\times/*/g;
    $sub =~ s/\\; //g;
    $sub =~ s/\\cdot/ . /g;
    $ss = quotemeta $i;
    $str =~ s/$ss/$sub/g;
}
print $str."\n";
