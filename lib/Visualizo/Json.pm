package Visualizo::Json;
use Mojo::Base 'Mojolicious::Controller';
use CodeJuicer::DB;

sub dsm {
  my $self = shift;
  my $graphs = CodeJuicer::DB->c('graphs')->find({ _id => $self->param('url_sha1') });
  $self->render(json => $graphs->next->{dsm});
}

1;
