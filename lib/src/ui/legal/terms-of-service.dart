import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                "Termos de Uso da Swappin",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF444444),
                ),
              ),
            ),
            //Introdução
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Introdução",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Agradecemos por utilizar a Swappin (“Swappin,” “empresa”). A Swappin fornece serviços por intermédio de suas tecnologias bem como serviços a serem desenvolvidos futuramente (doravante denominado como “serviços” ou “serviço”) para a compra e venda de produtos dos gêneros alimentício, têxtil, químico, farmacêutico e quaisquer outros gêneros de produtos que a empresa julgar necessário inserir futuramente (doravante denominados como “produto” ou “produtos”) para pessoas físicas devidamente cadastradas em nossos serviços (doravante denominados como “usuário”, “usuários”, “cliente” ou “clientes”) e pessoas jurídicas que trabalham no varejo de gêneros alimentício, têxtil, químico, farmacêutico e quaisquer outros gêneros que a empresa julgar necessário inserir futuramente (doravante denominados como “lojista” ou “lojistas”).",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Aceitação dos Termos de Uso da Swappin
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Aceitação dos Termos de Uso da Swappin",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A utilização dos serviços oferecidos pela empresa Swappin, localizada em Rua Durval José de Barros, número 327, 94A, São Paulo - SP, devidamente inscrita no CNPJ/MF sob o nº 00.000.000/0000 00, está sujeita à aceitação e ao cumprimento dos Termos e Condições de Uso providos neste documento (doravante denominados também como “termos” ou “documento”). Para que a utilização dos serviços seja realizada, é necessário:\n"
                "(i) Ler atentamente a este documento provido pela empresa Swappin;\n"
                "(ii) Concordar com o que foi expresso por este documento;\n"
                "(iii) Fornecer um e-mail válido para ter acesso aos serviços.\n\n"
                "Ao realizar a inscrição e/ou utilizar qualquer um de nossos serviços, o usuário concorda e afirma que leu, compreendeu e aceitou todos os termos, regras e condições propostos por este documento.\n\n"
                "A empresa se reserva o direito de alterar e/ou acrescentar quando julgar necessário qualquer funcionalidade de seus serviços. O mesmo é válido para estes Termos de Uso, estabelecidos, então, como fundamentais para a utilização de nossos serviços. ",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Sobre estes Termos
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Sobre estes Termos",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Em virtude de razões validas à empresa, como melhoria das funcionalidades existentes e adição de novas funcionalidades, a empresa reserva-se o direito de modificar, quando julgar necessário, estes ou quaisquer termos adicionais que sejam aplicáveis a quaisquer serviços providos pela empresa. Fica sob a responsabilidade do usuário consultar estes Termos regularmente. A empresa se propõe a postar avisos que notifiquem as modificações ocorridas dentro do serviço aplicável e/ou enviar um e-mail.  Em alguns casos, a empresa notificará com antecedência, e a sua utilização continuada dos serviços, após as alterações feitas pela empresa, constituirá sua aceitação destas alterações. Caso discorde das alterações realizadas nos termos de um serviço, é recomendado descontinuar o uso e encerrar a sua conta no serviço aplicável. Caso haja conflito entre os termos em vigor e os termos adicionais, os termos adicionais prevalecerão diante dos termos em vigor em relação a esse conflito. Caso os termos não sejam cumpridos por você e a empresa não tome as providências imediatas, não significa que a empresa está renunciando a quaisquer direitos que a empresa possa ter, como providências futuras.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Sobre os Serviços
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Sobre os Serviços",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A empresa oferece o serviço de possibilitar a visualização e escolha de produtos próximos, baseando-se, assim, em sua geolocalização. Oferece a  a possibilidade de solicitar e adquirir produtos providos por lojistas devidamente cadastradas em nossos serviços. A empresa tem como objetivo aproximar, por intermédio de seus serviços, clientes e lojistas cadastrados, provendo, então, a possibilidade de solicitação e aquisição de produtos por parte dos clientes e aceitação e entrega por parte dos lojistas. Portanto, fica expressamente esclarecido desde logo que o serviço oferecido pela empresa se limita apenas à intermediação para comercialização de produtos, não sendo a empresa responsável pelo preparo, qualidade, avarias, disponibilização e entrega física (retirada ou recebimento) dos produtos ou quaisquer insatisfação por parte do usuário em relação aos produtos adquiridos através dos serviços providos pela empresa, além de a empresa não ser responsável por quaisquer tipos de relação interpessoal entre cliente e lojista, sendo o último a quem deve ser endereçado quaisquer reclamações acerca de quaisquer problemas com o produto ou serviço prestado durante a retirada ou entrega e sendo tanto o usuário e/ou lojista responsáveis por todas as questões que ocorram entre os mesmos. A empresa oferece o serviço de mostrar a distância e localização da loja em que se encontra o produto e o lojista devidamente cadastrados (doravante também referidos como  “estabelecimento”  ou  “estabelecimentos”). Todavia, a empresa não se responsabiliza pelo deslocamento e meio de transporte utilizado por seus usuários até o estabelecimento. Qualquer acontecimento durante o deslocamento e trajeto do usuário até o estabelecimento é da responsabilidade do próprio usuário, assim como qualquer acontecimento durante a  permanência do usuário no estabelecimento e quaisquer outros locais em que o usuário possa se encontrar não são de responsabilidades da empresa.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Responsabilidades do Usuário
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Responsabilidades do Usuário",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Ao efetuar o cadastro ou atualização de dados, fica a encargo do usuário a NÃO divulgação a terceiros de seu e-mail cadastrado e senha de acesso, nem permitir a visualização e utilização destas informações por terceiros, responsabilizando-se, assim, pelas consequências do uso do e-mail cadastrado e senha sob sua titularidade. Fica a encargo do usuário o fornecimento de informações verídicas e exatas no cadastro ou atualização de dados, sendo o usuário responsável juridicamente por qualquer informação inverídica fornecida durante o cadastro ou atualizações de dados. Fica a encargo do usuário e do lojista a relação interpessoal mutualmente harmoniosa, não sendo de responsabilidade da empresa qualquer problema ou indisposição causadas, tanto por parte do usuário quanto por parte lojista, durante a retirada ou recebimento do produto adquirido pelos serviços da empresa, bem como durante a comunicação entre usuário e lojista durante utilização dos serviços. A empresa não se responsabiliza pelos comentários feitos pelo usuário sobre os produtos e serviços oferecidos pelo lojista, bem como a resposta do lojista sobre os comentários feitos pelos usuários. Fica a encargo do usuário e do lojista que, sendo o primeiro menor de 18 anos, ambos estão cientes que o usuário não poderá adquirir, em hipótese alguma, produtos alcóolicos ou proibidos para menores de 18 anos, ficando a encargo do usuário o fornecimento da idade correta durante o cadastro e a encargo do lojista não entregar produtos proibidos para menores de 18 anos bem como exigir um documento legal que comprove a maioridade do usuário. Também, no caso de usuários menores de 18 anos, fica a encargo dos responsáveis legais do usuário o monitoramento do uso dos serviços providos pela empresa, assim como qualquer proibição do uso de quaisquer serviços da empresa por parte do usuário menor de 18 anos.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Responsabilidades da Swappin
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Responsabilidades da Swappin",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A empresa disponibiliza serviços que fornecem a possibilidade do usuário visualizar, pesquisar e solicitar produtos a um website que fornece a possibilidade ao lojista de receber e notificar a aceitação da solicitação do produto por parte do lojista, além de fornecer ao usuário os meios de pagamentos que são aceitos pelo lojista, ficando a encargo tanto do usuário quanto do lojista quaisquer transações financeiras realizadas fora dos serviços da empresa.\n"
                "A empresa se compromete a proteger com confidencialidade, por intermédio de computação em nuvem, servidores e quaisquer outros meios armazenamento seguro, todas as informações e dados que tem relação aos usuários, bem como quaisquer valores transacionais que ocorram através dos serviços contidos nesse termo. Entretanto, a empresa não responderá pela reparação de prejuízos causados por terceiros que, sem o conhecimento da empresa, venham a romper os sistemas de segurança e, assim, apreender e cooptar dados advindos de nossos serviços.\n",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Para obter mais informações de como contatar a Swappin, visite nossa página: http://swappin.io",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              child: Text(
                "Data de atualização deste documento:  15/02/2020",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
