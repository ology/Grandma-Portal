#!/usr/bin/env perl
use Mojolicious::Lite -signatures;

use Capture::Tiny qw(capture);
use File::HomeDir ();
use List::Util ();

get '/' => sub ($c) {
  my $who = $c->param('who') || getlogin || getpwuid($<) || '';
  $who = 'default' unless -e "config/$who.yml";
  my $config = plugin NotYAMLConfig => { file => "config/$who.yml" };
  $c->render(
    template => 'index',
    links    => $config->{links},
    buttons  => $config->{buttons},
  );
} => 'index';

post '/' => sub ($c) {
  my $open = $c->param('open');
  if ($open) {
    my @folders = qw(Documents Music Pictures);
    my @cmd = ('open');
    if (List::Util::any { $_ eq $open } @folders) {
      my %dispatch = (
        Documents => File::HomeDir->my_documents,
        Music     => File::HomeDir->my_music,
        Pictures  => File::HomeDir->my_pictures,
      );
      $open = $dispatch{$open};
    }
    else {
      push @cmd, '-a';
    }
    push @cmd, $open;
    my ($stdout, $stderr, $exit) = capture { system(@cmd) };
    #print "Output:\n$stdout\n";
    warn "Error ($exit): \n$stderr\n" if $stderr;
  }
  $c->redirect_to('index');
} => 'open';

app->log->level('info');

app->start;

__DATA__

@@ index.html.ep
% layout 'default';
% title 'Portal';
% for my $link (@$links) {
<a
  href="<%= $link->{target} %>"
  class="btn btn-outline-dark btn-lg"
  target="_blank"
><i class="fa-solid <%= $link->{fa} %>"></i> <%= $link->{text} %></a>
% }
<p></p>
<form method="post">
% for my $link (@$buttons) {
  <button
    type="submit"
    class="btn btn-outline-dark btn-lg"
    name="open"
    value="<%= $link->{target} %>"
  ><i class="fa-solid <%= $link->{fa} %>"></i> <%= $link->{text} %></button>
% }
</form>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/css/fontawesome.css">
    <link rel="stylesheet" href="/css/solid.css">
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <title><%= title %></title>
    <link href="/css/style.css" rel="stylesheet">
  </head>
  <body>
    <p></p>
    <div class="container padpage faded rounded">
      <!-- <h3><a href="/"><%= title %></a></h3> -->
      <%= content %>
<!--
      <p></p>
      <div id="footer" class="smalltext">
        <hr>
        Built by <a href="http://gene.ology.net/">Gene</a>
        with <a href="https://www.perl.org/">Perl</a> and
        <a href="https://mojolicious.org/">Mojolicious</a>
        | <a href="/help">Help!</a>
      </div>
-->
    </div>
  </body>
</html>

