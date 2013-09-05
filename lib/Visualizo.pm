package Visualizo;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Config Defaults
  $self->defaults(
    layout => 'default',
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')
    ->name('home')
    ->to('repository#new_url');

  $r->get('/enqueue')
    ->name('enqueue')
    ->to('repository#enqueue');

  $r->get('/json/:url_sha1/:action')
    ->to('json#dsm');

  $r->get('/:url_sha1')
    ->name('visualization')
    ->to('repository#visualization');
}

1;
