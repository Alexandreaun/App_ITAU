# App_ITAU

Solução desenvolvida em Swift 5

Utilizado arquitetura MVC

MOCK:

Criado arquivo Json para nomes dos Contatos e seus dados bancários

NETWORK:

Realizado Serialization do Json a partir da Model Contact utilizando Codable.
Utilizado Clousure para validar o erro e preencher os contatos em um Array na Controller para posteriormente enviar as informaçoes para as Views.

CONTROLLERS:

TransacaoController: 
Criado array para trazer os contatos (arrayContact) e criado função "getJsonSerializer" para popular o array com os dados do Json e tratar o Erro caso Json apresente problemas ao carregar, disponibilizando a mensagem e os dados para a View TransacaoViewController. 
Criada toda a lógica para organização e apresentação da lista de contatos apresentada na View TransacaoViewController e lógica para transição de telas.

EfetivacaoController:
Criado apenas o Header e Footer da tableView utilizada na tela efetivacaoViewController.

MODEL:

Saldo das contas setado de forma fixa no Model.
Utilizado Design Patterns "Singleton" para transitar o saldo entre as telas "transacao" e "efetivacao", devolvendo o saldo atualizado para a tela de transação após a efetivação da transferência.
Mensagens de Erro e Confirmações criadas com orientação a objetos. Criado um Objeto ValidationError. Em Extensions, utilizado uma extension de UIViewController para mostrar os alertas de efetivação das transferências, além de um tratamento de erro em casos de problemas com a requisição da lista de contatos. Criado uma StringExtension para formatação do textField para configurar as casas decimais do valor digitado. 
Criado Contact a partir dos dados do Json.

VIEW:

TransacaoViewController: 
Criado duas TableViews, uma para Saldo das contas e outra para os contatos. Lógica das views setadas nos métodos de criação das células e da linha selecionada com base na tableview selecionada, buscando as informações da TransacaoController. Lógica de checkmark criado.

EfetivacaoViewController:
Criada uma tableView para receber a conta selecionada, realizada toda a configuração dos botões e layout da tela, recebendo os dados do contato selecionado da tela de transacao. Após setado o valor da transferência, confirmando a operação, o valor de transferência será subtraido da conta selecionada e atualizando o resultado e enviado para a conta utilizada na tela transacaoViewController, ficando assim o saldo atualizado para a próxima transação. Setado todos os alertas em caso de digitação errada ou valores superiores ao pré-estabelecido.

