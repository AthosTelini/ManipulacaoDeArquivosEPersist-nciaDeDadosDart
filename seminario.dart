import 'dart:io';

final String nomeArquivo = 'usuarios.txt';


void main() async {
  while (true) {
    print('\n--- Mini Cadastro de Usuários ---');
    print('1 - Adicionar Usuário');
    print('2 - Listar Usuários');
    print('3 - Limpar e Reescrever Arquivo (Demonstração)');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');

    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        await adicionarUsuario();
        break;
      case '2':
        await listarUsuarios();
        break;
      case '3':
        await reescreverArquivo();
        break;
      case '0':
        print('Saindo do programa...');
        return;
      default:
        print('Opção inválida! Tente novamente.');
    }
  }
}

// Função para adicionar um novo usuário
Future<void> adicionarUsuario() async {
  // 4. Pedindo os dados para o usuário.
  stdout.write('Digite o nome do usuário: ');
  String nome = stdin.readLineSync() ?? 'Nome Padrão';
  stdout.write('Digite o email do usuário: ');
  String email = stdin.readLineSync() ?? 'email@padrao.com';

  // 5. Formatando os dados para salvar no arquivo. Usamos vírgula como separador
  //    e '\n' para que o próximo usuário seja salvo em uma nova linha.
  String dadosFormatados = '$nome, $email\n';

  // 6. Criando uma referência ao nosso arquivo.
  final arquivo = File(nomeArquivo);

  // 7. Escrevendo no arquivo. O 'mode: FileMode.append'
  //    Ele garante que os novos dados sejam adicionados NO FINAL do arquivo,
  //    sem apagar quem já estava cadastrado.
  await arquivo.writeAsString(dadosFormatados, mode: FileMode.append);

  print('\n✅ Usuário "$nome" salvo com sucesso!');
}

// Função para ler e mostrar os usuários salvos
Future<void> listarUsuarios() async {
  print('\n--- Lista de Usuários Cadastrados ---');
  final arquivo = File(nomeArquivo);

  if (await arquivo.exists()) {
    final linhas = await arquivo.readAsLines();

    if (linhas.isEmpty) {
      print('Nenhum usuário cadastrado.');
    } else {
      for (var linha in linhas) {
        final dados = linha.split(',');
        if (dados.length == 2) {
          print('Nome: ${dados[0]} | Email: ${dados[1]}');
        }
      }
    }
  } else {
    print(
      'O arquivo de usuários ainda não existe. Adicione o primeiro usuário.',
    );
  }
  print('------------------------------------');
}

// Função para demonstrar a reescrita (apagando o conteúdo anterior)
Future<void> reescreverArquivo() async {
  print('\n--- Demonstração de Reescrita ---');
  final arquivo = File(nomeArquivo);

  // 13. Aqui, usamos o modo padrão, que é 'FileMode.write'.
  //     Ele vai apagar todo o conteúdo do arquivo antes de escrever.
  String novoConteudo = 'Administrador, admin@sistema.com\n';
  await arquivo.writeAsString(novoConteudo); // Sem 'mode', o padrão é apagar.

  print(
    '✅ Arquivo foi limpo e um novo usuário "Administrador" foi adicionado.',
  );
  print('Liste os usuários novamente para ver o resultado.');
}
