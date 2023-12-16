#!/usr/bin/env perl
use Mojolicious::Lite -signatures;

use File::HomeDir ();
use List::Util ();

get '/' => sub ($c) {
  $c->render(template => 'index');
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
    system(@cmd) == 0 or warn "Can't system(@cmd): $?";
  }
  $c->redirect_to('index');
} => 'open';

app->log->level('info');

app->start;

__DATA__

@@ index.html.ep
% layout 'default';
% title 'Portal';

% my $class = 'btn btn-outline-dark btn-lg';

<a href="https://mail.google.com/mail/u/0/#inbox" class="<%= $class %>" target="_blank"><i class="fa-solid fa-inbox"></i> Gmail</a>
<a href="https://www.google.com/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-magnifying-glass"></i> Google</a>
<a href="https://www.facebook.com/groups/631391120534459/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-tree-city"></i> Fairview</a>
<a href="https://family.ology.net/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-people-group"></i> Family</a>
<a href="https://www.instacart.com/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-cart-shopping"></i> Instacart</a>
<a href="https://news.google.com/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-newspaper"></i> News</a>
<a href="https://weather.com/weather/today/l/39.59,-80.25" class="<%= $class %>" target="_blank"><i class="fa-solid fa-sun"></i> Weather</a>
<a href="https://www.wikipedia.org/" class="<%= $class %>" target="_blank"><i class="fa-solid fa-book-atlas"></i> Wikipedia</a>
<p></p>

<form method="post">
  <button type="submit" class="<%= $class %>" name="open" value="LibreOffice"><i class="fa-solid fa-paragraph"></i> LibreOffice</button>
  <button type="submit" class="<%= $class %>" name="open" value="Solitare"><i class="fa-solid fa-diamond"></i> Solitare</button>
  <p></p>
  <button type="submit" class="<%= $class %>" name="open" value="Documents"><i class="fa-solid fa-file-lines"></i> Documents</button>
  <button type="submit" class="<%= $class %>" name="open" value="Music"><i class="fa-solid fa-music"></i> Music</button>
  <button type="submit" class="<%= $class %>" name="open" value="Pictures"><i class="fa-solid fa-camera-retro"></i> Pictures</button>
</form>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/css/fontawesome.css" rel="stylesheet">
    <link href="/css/solid.css" rel="stylesheet">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
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

