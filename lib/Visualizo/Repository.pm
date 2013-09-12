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

sub explore {
  my $self = shift;
  my @repositories = CodeJuicer::DB->c('repositories')->find()->all;
  my %repositories_list = map { $_->{_id} => $_->{url} } @repositories;
  $self->stash(
    repositories => \%repositories_list,
  );
}

sub visualization {
  my $self = shift;
  my $url_sha1 = $self->param('url_sha1');
  my $repositories = CodeJuicer::DB->c('repositories')->find({ _id => $url_sha1 });
  my $repository = $repositories->next;
  my $metrics = CodeJuicer::DB->c('metrics')->find({ _id => $url_sha1 });
  my $metric = $metrics->next;
  my $graphs = CodeJuicer::DB->c('graphs')->find({ _id => $url_sha1 });
  my $graph = $graphs->next;
  my $total_files = @{ $graph->{dsm}->{nodes} };
  $self->stash(
    message => 'Visualização do repositório...',
    url_sha1 => $url_sha1,
    url => $repository->{url},
    total_files => $total_files,
    metrics => {
      change_cost => $metric->{global_metrics}->{change_cost},
      lcom4_mean => $metric->{global_metrics}->{lcom4_mean},
      total_loc => $metric->{global_metrics}->{total_loc},
    },
  );
}

1;
