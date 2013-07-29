package Visualizo::Repository;
use Mojo::Base 'Mojolicious::Controller';

use Digest::SHA qw(sha1_hex);

sub enqueue {
  my $self = shift;

  my $url = $self->param('url');
  my $url_sha1 = sha1_hex($url);

  # 1) conecte no Avizo, passe a URL para ele, solicite FETCH
  # pegue o seu retorno em relação ao status da tarefa (fetch,
  # metrics, graphs, ...).
  # 2) O Avizo deve automaticamente executar as tarefas de analisar,
  # gerar metricas e graficos após o download.
  # 3) O Visualizo em sí deve evitar ao máximo armazenar informações,
  # se possível ele nem terá um banco de dados.

  # Render template "example/welcome.html.ep" with message
  $self->render(
    message => 'Aguarde, estamos fazendo download do repositório...',
    url_sha1 => $url_sha1,
  );
}

1;
