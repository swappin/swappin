import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
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
                "TÍtulo",
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
                "Nós da Swappin temos compreensão de que você está confiando a nós as suas informações quando utiliza nossos serviços e entendemos a importância e responsabilidade que isso nos acarreta. Sendo assim, nós utilizamos seus dados com o propósito de proporcionar um serviço e experiência cada vez mais eficaz e trabalhamos duro para proteger essas informações que nos são fornecidas. Esta Política de Privacidade tem como objetivo descrever, esclarecer e ajudar você a entender como obtemos, armazenamos, gerenciamos e compartilhamos essas informações.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Quais tipos de informações coletamos? 
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Quais tipos de informações coletamos?",
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
                "Com o objetivo de otimizar a experiência de nossos usuários e prover serviços cada vez melhores, nós coletamos e estudamos dados fornecidos pelo usuário ao utilizar nossos serviços. Abaixo detalhamos quais dados coletamos e o porquê de coletarmos:",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Informações que você nos fornece:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Ao se inscrever para ser um usuário registrado e utilizar nossos serviços, você nos fornece informações pessoais que incluem seu nome, data de nascimento, gênero, endereço eletrônico, senha, CPF e número de telefone e, durante o uso, sua localização atual através de sua latitude e longitude.\n"
                    "A Swappin também provê a opção de cadastro utilizando contas de terceiros como o Google e o Facebook. Quando você realiza o cadastro na Swappin por intermédio do Google ou Facebook, você estará permitindo que a Swappin acesse as informações pessoais de sua conta do Google ou Facebook, tais como: nome, gênero, idade e telefone (caso o mesmo esteja cadastrado em sua conta do Google ou Facebook). Portanto, estas informações que podemos obter com seu cadastro via Google ou Facebook dependem de suas configurações de privacidade junto ao Google ou Facebook.\n\n"
                    "As informações acerca de sua localização atual podem ser obtidas através de informações fornecidas por GPS e redes móveis (Wi-Fi, torres de celular e outras formas de localização), devidamente aceitas por você, e as informações coletadas tem como objetivo de indicar lojas e produtos que estão perto de você. Os tipos de dados de localização coletados pela Swappin podem depender do dispositivo em questão e das configurações do dispositivo e da conta, sendo possível a ativação ou desativação dos serviços de localização através das configurações do dispositivo. Todavia, por ter seus serviços baseados em geolocalização, o desativamento dos serviços de localização interferirá diretamente na experiência de uso do serviço.\n\n"
                    "Além dessas informações, podemos colher outros dados como informações sobre o seu dispositivo, tais como: endereços IP, sistema operacional, idioma, provedor de serviços de Internet (ISP), data e horário, páginas acessadas, cliques realizados durante o uso de nossos serviços, fabricante do dispositivo, informações de operadora, modelo do dispositivo, redes Wi-Fi, número de telefone, entre outras que a Swappin julgar relevante para a otimização da  experiência do usuário. "
                ,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Como utilizamos essas informações?
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Como utilizamos essas informações?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Fornecer nossos serviços:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A Swappin conecta você à lojistas e produtos próximos a você baseado em sua localização atual. A utilização de seus dados tem como objetivo maior promover essa conexão. Sem os dados fornecidos por você, somos incapazes de criar essa conexão e prover nossos serviços. A utilização de sua geolocalização nos ajuda a encontrar lojas e produtos próximos ao local onde você se encontra.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Otimizar nossos serviços:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Coletamos informações para otimizar nossos produtos e serviços com o objetivo de fornecer a você uma melhor experiência de uso dos produtos existentes ou dos produtos que possam a ser criados por nós. Também estudamos os dados coletamos com a finalidade de melhorar nossos produtos e serviços. Por exemplo, podemos analisar quais páginas são as mais acessadas por nossos usuários para compreender a razão de tal página ter mais acessos e replicar possíveis características para as demais páginas com o objetivo de tornar a experiência mais intuitiva. Podemos também analisar quais os produtos que você mais compra e onde você mais compra para que indicarmos as melhores opções e lojas próximas de acordo com o seu perfil. ",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Otimização de nossos parceiros:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Coletamos informações de compra e alguns dados pessoais para ajudar nossos parceiros lojistas a elaborarem e oferecerem um melhor serviço a você. Essas informações vão desde os comentários e avaliações do(s) produto(s) e serviço(s) prestado(s) pelo lojista até como você navega pelas páginas das lojas em nosso aplicativo. O objetivo da obtenção dessas informações é gerar dados que ajudem nossos parceiros a oferecer serviços e aprimorar produtos de modo que atendam da melhor forma as necessidades de nossos usuários.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Contatar nossos  usuários:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Através do endereço de e-mail e outros dados fornecidos, podemos entrar em contato com você, seja para resolver um problema ou enviar um aviso. Por exemplo, por meio deste e-mail, podemos enviar um link para que você possa recuperar a sua senha. Em caso de fraudes em sua conta, são esses dados que nos ajudam a identificar o problema e te dar auxilio na resolução.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            //Como armazenamos essas informações?
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Como armazenamos essas informações?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Onde armazenamos essas informações:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A nossa tecnologia utiliza serviços de computação em nuvem de confiança de parceiros consolidados. Os dados, assim como os parceiros, podem estar localizados no Brasil ou no exterior, sendo que, em ambos os casos, para o armazenamento dos mesmos são utilizadas tecnologias seguras de parceiros confiáveis que prestam serviços também para as outras grandes empresas de tecnologia. A Swappin preza por um bom serviço e, portanto, busca utilizar serviços e fazer parcerias com empresas que agregam algo nível de segurança e compactua com o quanto levamos a sério os dados fornecidos por nossos usuários.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Como protegemos essas informações:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "A Swappin leva muito a sério as informações fornecidas por você durante a adesão de nossos serviços. Sendo assim, a Swappin emprega seus melhores esforços na  proteção de seus dados contra fraudes, roubos, perdas ou qualquer forma de uso indevido de suas informações. Os serviços escolhidos pela Swappin são de parceiros que agregam as maiores técnicas de segurança do mundo e nós nos inspiramos e adotamos os mesmos princípios, implementando práticas similares em nosso dia-a-dia, tais como técnicas de criptografia e testes de segurança periódicos.",
                style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                color: Color(0xFF666666),
              ),
              ),
            ),
            //Como excluir essas informações?
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Como excluir essas informações?",
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
                "Nós da  Swappin utilizamos suas informações durante o período em que você possui uma conta conosco. Se você solicitar a exclusão de sua conta, as suas informações que foram fornecidas durante a utilização de nossos serviços serão excluídas permanentemente levando em conta todos os pormenores da legislação. Podemos, após a exclusão da conta, manter alguns dados caso você tenha alguma questão pendente com a Swappin, como, por exemplo, uma reclamação em andamento, ou por interesses comerciais por parte da Swappin em aprimorar os seus serviços e sua segurança.",
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
