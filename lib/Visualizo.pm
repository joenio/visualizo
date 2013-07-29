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
  $r->get('/')->to('repository#new_url');
  $r->get('/enqueue')->to('repository#enqueue');
}

1;
