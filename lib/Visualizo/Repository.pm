package Visualizo::Repository;
use Mojo::Base 'Mojolicious::Controller';
use Digest::SHA qw(sha1_hex);
use CodeJuicer::DB;

sub enqueue {
  my $self = shift;
  my $url = $self->param('url');
  my $url_sha1 = sha1_hex($url);
  $self->stash(
    message => 'Aguarde, estamos fazendo download do repositório...',
    url_sha1 => $url_sha1,
  );
}

sub visualization {
  my $self = shift;
  my $url_sha1 = $self->param('url_sha1');
  my $repositories = CodeJuicer::DB->c('repositories')->find({ _id => $url_sha1 });
  my $repository = $repositories->next;
  $self->stash(
    message => 'Visualização do repositório...',
    url_sha1 => $url_sha1,
    url => $repository->{url},
  );
}

1;
