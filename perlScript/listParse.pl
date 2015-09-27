#!/usr/bin/perl
use List::MoreUtils qw(uniq);
use Cwd 'abs_path';
my $path = abs_path($0);
$path =~ s/\/[^\/]*\/[^\/]*$//;
my $httpsh = $path."\/http.sh";
my $URLs = "http:\/\/judgegirl.csie.org";
sub listProblems{
    $HTML = $_[0];
    $HTML = join '', split /\n/, $HTML;
    @problemsRaw = ($HTML =~ m/<tr.*?<a[^>]*href="\/*problem\/[0-9]*\/[0-9]*"[^>]*>.*?<\/a>.*?<\/tr>/sg);
    for my $i (@problemsRaw){
        $pass = ($i =~ m/fa\-check/g)?"O":"X";
        if(!($ARGV[0]) || $pass eq "X" ){
            $i =~ m/<a[^>]*href="\/*problem\/([0-9]*)\/([0-9]*)"[^>]*>(.*?)<\/a>/s;
            $cid = $1;
            $pid = $2;
            $title = $3;
            $title =~ s/^\s*//sg;
            $title =~ s/\s*$//sg;
            $title =~ s/$pid\.\s*//sg;
            print "[$pass] $title\n    cid: $cid, pid: $pid\n\n"
        }
    }
}
print "====Problems====\n\n";
$HTML =`$httpsh $URLs\/problems`;
&listProblems($HTML);
print "==//Problems//==\n";

my $contestHTML = `$httpsh $URLs\/contests`;
$contestHTML = join '', split /\n/, $contestHTML;
my @contestsRaw = ($contestHTML =~ m/<tr[^>]*class="[^"]*cunning[^"]*"[^>]*>.*?<\/tr>/sg);
for my $i (@contestsRaw){
    if($i =~ m/contest\/([0-9]*)/s){
        my $cid = $1;
        $i =~ m/<a.*?>(.*?)<\/a>/s;
        my $title = $1;
        $title =~ s/^\s*//sg;
        $title =~ s/\s*$//sg;
        $title =~ s/$cid\.\s*//sg;
        print "\n\n====Exam $cid: $title====\n\n";
        $HTML =`$httpsh $URLs\/contest\/$cid`;
        &listProblems($HTML);
        print "==//Exam $cid//==\n";
    }
}
