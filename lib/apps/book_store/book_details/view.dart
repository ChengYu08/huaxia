import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/book_details/test.dart';
import 'package:huaxia/config/assets/imgs.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/book_cover.dart';
import 'package:huaxia/widgets/drop_shadow_image.dart';

import 'logic.dart';

class BookDetailsPage extends StatelessWidget {
  final logic = Get.find<BookDetailsLogic>();

  String     data = '''
  \n　　子曰：“为政以德，譬如北辰，居其所而众星共之。”\n
　子曰：“《诗》三百，一言以蔽之，曰：‘思无邪’。”\n
  <p>　　子曰：<u>“道之以政，齐之<u>以刑</u>，民免而无耻。道</u>之以德，齐之以礼，有耻且格。”</p>\n
  <p>　　子曰：“吾十有五而志于学，三十而立，四十而不惑，五十而知天命，六十而耳顺，七十而从心所欲，不逾矩。”</p>\n<p>　　孟懿子问孝，子曰：“无违。”樊迟御，子告之曰：“孟孙问孝于我，我对曰‘无违’。”樊迟曰：“何谓也？”子曰：“生，事之以礼；死，葬之以礼，祭之以礼。”</p>\n<p>　　孟武伯问孝。子曰：“父母唯其疾之忧。”</p>\n<p>　　子游问孝。子曰：“今之孝者，是谓能养。至于犬马，皆能有养；不敬，何以别乎？”</p>\n<p>　　子夏问孝。子曰：“色难。有事，弟子服其劳；有酒食，先生馔，曾是以为孝乎？”</p>\n<p>　　子曰：“吾与回言终日，不违，如愚。退而省其私，亦足以发，回也不愚。”</p>\n<p>　　子曰：“视其所以，观其所由，察其所安，人焉廋哉？人焉廋哉？”</p>\n<p>　　子曰：“温故而知新，可以为师矣。”</p>\n<p>　　子曰：“君子不器。”</p>\n<p>　　子贡问君子。子曰：“先行其言而后从之。”</p>\n<p>　　子曰：“君子周而不比，小人比而不周。”</p>\n<p>　　子曰：“学而不思则罔，思而不学则殆。”</p>\n<p>　　子曰：“攻乎异端，斯害也已！”</p>\n<p>　　子曰：“由，诲女知之乎！知之为知之，不知为不知，是知也。”</p>\n<p>　　子张学干禄。子曰：“多闻阙疑，慎言其余，则寡尤；多见阙殆，慎行其余，则寡悔。言寡尤，行寡悔，禄在其中矣。”</p>\n<p>　　哀公问曰：“何为则民服？”孔子对曰：“举直错诸枉，则民服；举枉错诸直，则民不服。”</p>\n<p>　　季康子问：“使民敬、忠以劝，如之何？”子曰：“临之以庄，则敬；孝慈，则忠；举善而教不能，则劝。”</p>\n<p>　　或谓孔子曰：“子奚不为政？”子曰：“《书》云：‘孝乎惟孝，友于兄弟。’施于有政，是亦为政，奚其为为政？”</p>\n<p>　　子曰：“人而无信，不知其可也。大车无輗，小车无軏，其何以行之哉？”</p>\n<p>　　子张问：“十世可知也？”子曰：“殷因于夏礼，所损益，可知也；周因于殷礼，所损益，可知也。其或继周者，虽百世，可知也。”</p>\n<p>　　子曰：“非其鬼而祭之，谄也；见义不为，无勇也。”</p>\n",
		"yiwen": "\n<p>　　孔子说：“用道德来统治国家的人，就会像北极星一样处在一定的位置，所有的星辰都会环绕在它的周围。”</p>\n<p>　　孔子说：“《诗经》三百篇，可以用一句话来概括它，就是‘思想纯正’。”</p>\n<p>　　孔子说：“用强权手段、法制禁令来管理百姓，使用刑法来约束他们，老百姓只能免于犯罪受惩罚，却没有了廉耻之心；用道德引导百姓，用礼制去统一百姓的言行，不但懂得廉洁是非，而且从心里归服。”</p>\n<p>　　孔子说：“我十五岁立志于学习；三十岁就有了自己的德行和做人的原则；四十岁遇到事情不再感到困惑；五十岁就知道哪些是不能为人力支配的事情而乐知天命；六十岁能正确对待各种言论，不觉得不能接受；七十岁能随心所欲而不越出规矩。”</p>\n<p>　　孟懿子问什么是孝，孔子说：“孝就是不要违背礼。”不久，樊迟替孔子驾车，孔子告诉他说：“孟孙问我什么是孝道，我回答他说不要违背礼。”樊迟说：“这是什么意思呢？”孔子说：“父母活着的时候，要依照规定的礼节侍奉他们；父母去世后，依规定的礼节安葬他们，祭祀他们。”</p>\n<p>　　孟武伯问什么是孝。孔子说：“除生病不能避免外，不要让父母担忧子女的任何事情。”</p>\n<p>　　子游问什么是孝。孔子说：“当今许多人认为的孝呀，就是能够赡养父母便足够了。其实狗和马，也都有人饲养。如果对自己的父母不恭敬孝顺，那么赡养父母与饲养犬马又有什么区别呢？”</p>\n<p>　　子夏问什么是孝。孔子说：“侍奉父母时，最不容易的就是对父母和颜悦色。有了事情，儿女替父母去做，有了可口的饭菜，让父母吃，难道能认为这样就可以算是孝了吗？”</p>\n<p>　　孔子说：“我给颜回授课，一整天下来他都不提任何反对意见和疑问，像个愚钝的人。等他回去后，我观察他私下里同别人讨论时，却能发挥我所讲的，可见颜回他并不愚笨呀！”</p>\n<p>　　孔子说：“看一个人的所作所为，应看他言行的动机，观察他所走的道路，了解他心安于什么事情。这样，这个人怎样能隐藏得了呢？这个人怎样能隐藏得了呢？”</p>\n<p>　　孔子说：“温习学过的知识，可以从中获得新的理解与体会，那么就可以凭借这一点去做老师了。”</p>\n<p>　　孔子说：“君子不像器具那样，只有一种用途。”</p>\n<p>　　子贡问怎样做一个君子。孔子说：“应该先行动实践自己想要说的话，做到后再把它说出来。”</p>\n<p>　　孔子说：“德行高尚的人以正道广泛交友但不互相勾结，品格卑下的人互相勾结却不顾道义。”</p>\n<p>　　孔子说：“只学习却不思考，就会感到迷茫而无所适从，只是思考而不学习，就会疑惑而无所得。”</p>\n<p>　　孔子说：“研攻异端杂学，不过带来危害罢了。”</p>\n<p>　　孔子说：“仲由啊，让为师教导你对待知与不知的态度吧！知道就是知道，不知道就是不知道，这才是聪明的。”</p>\n<p>　　子张要学谋取官职的办法。孔子说：“要多听，不明白的地方先放在一旁不说，对于真正懂得的，也要谨慎地说出来，这样就能少犯错误；要多看，有疑惑的先放在一旁不做，对于真正懂的，也要谨慎地去做，这样就能减少事后懊悔。说话很少犯错，做事很少后悔，自然就有官职俸禄了。”</p>\n<p>　　鲁哀公问：“用什么方法才能让老百姓服从呢？”孔子回答说：“提拔那些正直的人，让他们居于不正直的人之上，老百姓就会服从了；把不正直的人提拔上来，让他们居于正直的人之上，老百姓就不会服从统治了。”</p>\n<p>　　季康子问道：“要让老百姓恭敬、尽忠并互相勉励，应该怎么做呢？”孔子说：“如果你用庄重的态度对待他们，他们就会恭敬；如果你能孝顺父母、爱护幼小，他们就会忠诚；如果你能任用贤能之士，教育能力低下的人，他们就会互相勉励。”</p>\n<p>　　有人对孔子说：“你为什么不去从政呢？”孔子回答说：“《尚书》上说，‘孝就是孝敬父母，友爱兄弟。’把这孝悌的道理施于政事，也就是参与政事了，你以为要怎样才能算是参与政事呢？”</p>\n<p>　　孔子说：“一个人如果不讲信用，不知道他还能做什么。就好像牛车没有大车辕和车辕前横木相接的关键，马车没有辕前横木两端的木销，它还怎么行驶呢？”</p>\n<p>　　子张问孔子：“今后十世的礼仪制度可以预知吗？”孔子回答说：“商朝承袭了夏朝的礼仪制度，其中减少和所增加的内容是可以知道的；周朝又承袭了商朝的礼仪制度，其中减少和所增加的内容也是可以知道的。以后如果有继承周朝的朝代，就是一百世以后的情况，也是可以预先知道的。”</p>\n<p>　　孔子说：“不是自己的先祖而去祭祀，就是谄媚。见到应该挺身而出的事情，却袖手旁观，就是怯懦。”</p>\n",
		"duanluo": "\n<p>　　子曰：“为政以德，譬如北辰，居其所而众星共之。”<br/><span style=\"color:#af9100;\">　　孔子说：“用道德来统治国家的人，就会像北极星一样处在一定的位置，所有的星辰都会环绕在它的周围。”</span></p><p>　　子曰：“《诗》三百，一言以蔽之，曰：‘思无邪’。”<br/><span style=\"color:#af9100;\">　　孔子说：“《诗经》三百篇，可以用一句话来概括它，就是‘思想纯正’。”</span></p><p>　　子曰：“道之以政，齐之以刑，民免而无耻。道之以德，齐之以礼，有耻且格。”<br/><span style=\"color:#af9100;\">　　孔子说：“用强权手段、法制禁令来管理百姓，使用刑法来约束他们，老百姓只能免于犯罪受惩罚，却没有了廉耻之心；用道德引导百姓，用礼制去统一百姓的言行，不但懂得廉洁是非，而且从心里归服。”</span></p><p>　　子曰：“吾十有五而志于学，三十而立，四十而不惑，五十而知天命，六十而耳顺，七十而从心所欲，不逾矩。”<br/><span style=\"color:#af9100;\">　　孔子说：“我十五岁立志于学习；三十岁就有了自己的德行和做人的原则；四十岁遇到事情不再感到困惑；五十岁就知道哪些是不能为人力支配的事情而乐知天命；六十岁能正确对待各种言论，不觉得不能接受；七十岁能随心所欲而不越出规矩。”</span></p><p>　　孟懿子问孝，子曰：“无违。”樊迟御，子告之曰：“孟孙问孝于我，我对曰‘无违’。”樊迟曰：“何谓也？”子曰：“生，事之以礼；死，葬之以礼，祭之以礼。”<br/><span style=\"color:#af9100;\">　　孟懿子问什么是孝，孔子说：“孝就是不要违背礼。”不久，樊迟替孔子驾车，孔子告诉他说：“孟孙问我什么是孝道，我回答他说不要违背礼。”樊迟说：“这是什么意思呢？”孔子说：“父母活着的时候，要依照规定的礼节侍奉他们；父母去世后，依规定的礼节安葬他们，祭祀他们。”</span></p><p>　　孟武伯问孝。子曰：“父母唯其疾之忧。”<br/><span style=\"color:#af9100;\">　　孟武伯问什么是孝。孔子说：“除生病不能避免外，不要让父母担忧子女的任何事情。”</span></p><p>　　子游问孝。子曰：“今之孝者，是谓能养。至于犬马，皆能有养；不敬，何以别乎？”<br/><span style=\"color:#af9100;\">　　子游问什么是孝。孔子说：“当今许多人认为的孝呀，就是能够赡养父母便足够了。其实狗和马，也都有人饲养。如果对自己的父母不恭敬孝顺，那么赡养父母与饲养犬马又有什么区别呢？”</span></p><p>　　子夏问孝。子曰：“色难。有事，弟子服其劳；有酒食，先生馔，曾是以为孝乎？”<br/><span style=\"color:#af9100;\">　　子夏问什么是孝。孔子说：“侍奉父母时，最不容易的就是对父母和颜悦色。有了事情，儿女替父母去做，有了可口的饭菜，让父母吃，难道能认为这样就可以算是孝了吗？”</span></p><p>　　子曰：“吾与回言终日，不违，如愚。退而省其私，亦足以发，回也不愚。”<br/><span style=\"color:#af9100;\">　　孔子说：“我给颜回授课，一整天下来他都不提任何反对意见和疑问，像个愚钝的人。等他回去后，我观察他私下里同别人讨论时，却能发挥我所讲的，可见颜回他并不愚笨呀！”</span></p><p>　　子曰：“视其所以，观其所由，察其所安，人焉廋哉？人焉廋哉？”<br/><span style=\"color:#af9100;\">　　孔子说：“看一个人的所作所为，应看他言行的动机，观察他所走的道路，了解他心安于什么事情。这样，这个人怎样能隐藏得了呢？这个人怎样能隐藏得了呢？”</span></p><p>　　子曰：“温故而知新，可以为师矣。”<br/><span style=\"color:#af9100;\">　　孔子说：“温习学过的知识，可以从中获得新的理解与体会，那么就可以凭借这一点去做老师了。”</span></p><p>　　子曰：“君子不器。”<br/><span style=\"color:#af9100;\">　　孔子说：“君子不像器具那样，只有一种用途。”</span></p><p>　　子贡问君子。子曰：“先行其言而后从之。”<br/><span style=\"color:#af9100;\">　　子贡问怎样做一个君子。孔子说：“应该先行动实践自己想要说的话，做到后再把它说出来。”</span></p><p>　　子曰：“君子周而不比，小人比而不周。”<br/><span style=\"color:#af9100;\">　　孔子说：“德行高尚的人以正道广泛交友但不互相勾结，品格卑下的人互相勾结却不顾道义。”</span></p><p>　　子曰：“学而不思则罔，思而不学则殆。”<br/><span style=\"color:#af9100;\">　　孔子说：“只学习却不思考，就会感到迷茫而无所适从，只是思考而不学习，就会疑惑而无所得。”</span></p><p>　　子曰：“攻乎异端，斯害也已！”<br/><span style=\"color:#af9100;\">　　孔子说：“研攻异端杂学，不过带来危害罢了。”</span></p><p>　　子曰：“由，诲女知之乎！知之为知之，不知为不知，是知也。”<br/><span style=\"color:#af9100;\">　　孔子说：“仲由啊，让为师教导你对待知与不知的态度吧！知道就是知道，不知道就是不知道，这才是聪明的。”</span></p><p>　　子张学干禄。子曰：“多闻阙疑，慎言其余，则寡尤；多见阙殆，慎行其余，则寡悔。言寡尤，行寡悔，禄在其中矣。”<br/><span style=\"color:#af9100;\">　　子张要学谋取官职的办法。孔子说：“要多听，不明白的地方先放在一旁不说，对于真正懂得的，也要谨慎地说出来，这样就能少犯错误；要多看，有疑惑的先放在一旁不做，对于真正懂的，也要谨慎地去做，这样就能减少事后懊悔。说话很少犯错，做事很少后悔，自然就有官职俸禄了。”</span></p><p>　　哀公问曰：“何为则民服？”孔子对曰：“举直错诸枉，则民服；举枉错诸直，则民不服。”<br/><span style=\"color:#af9100;\">　　鲁哀公问：“用什么方法才能让老百姓服从呢？”孔子回答说：“提拔那些正直的人，让他们居于不正直的人之上，老百姓就会服从了；把不正直的人提拔上来，让他们居于正直的人之上，老百姓就不会服从统治了。”</span></p><p>　　季康子问：“使民敬、忠以劝，如之何？”子曰：“临之以庄，则敬；孝慈，则忠；举善而教不能，则劝。”<br/><span style=\"color:#af9100;\">　　季康子问道：“要让老百姓恭敬、尽忠并互相勉励，应该怎么做呢？”孔子说：“如果你用庄重的态度对待他们，他们就会恭敬；如果你能孝顺父母、爱护幼小，他们就会忠诚；如果你能任用贤能之士，教育能力低下的人，他们就会互相勉励。”</span></p><p>　　或谓孔子曰：“子奚不为政？”子曰：“《书》云：‘孝乎惟孝，友于兄弟。’施于有政，是亦为政，奚其为为政？”<br/><span style=\"color:#af9100;\">　　有人对孔子说：“你为什么不去从政呢？”孔子回答说：“《尚书》上说，‘孝就是孝敬父母，友爱兄弟。’把这孝悌的道理施于政事，也就是参与政事了，你以为要怎样才能算是参与政事呢？”</span></p><p>　　子曰：“人而无信，不知其可也。大车无輗，小车无軏，其何以行之哉？”<br/><span style=\"color:#af9100;\">　　孔子说：“一个人如果不讲信用，不知道他还能做什么。就好像牛车没有大车辕和车辕前横木相接的关键，马车没有辕前横木两端的木销，它还怎么行驶呢？”</span></p><p>　　子张问：“十世可知也？”子曰：“殷因于夏礼，所损益，可知也；周因于殷礼，所损益，可知也。其或继周者，虽百世，可知也。”<br/><span style=\"color:#af9100;\">　　子张问孔子：“今后十世的礼仪制度可以预知吗？”孔子回答说：“商朝承袭了夏朝的礼仪制度，其中减少和所增加的内容是可以知道的；周朝又承袭了商朝的礼仪制度，其中减少和所增加的内容也是可以知道的。以后如果有继承周朝的朝代，就是一百世以后的情况，也是可以预先知道的。”</span></p><p>　　子曰：“非其鬼而祭之，谄也；见义不为，无勇也。”<br/><span style=\"color:#af9100;\">　　孔子说：“不是自己的先祖而去祭祀，就是谄媚。见到应该挺身而出的事情，却袖手旁观，就是怯懦。”</span></p>\n
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Image.asset(
              Imgs.ic_add_book,
              width: 24,
              height: 24,
            ),
            label: Text(
              '加入书架',
              style: Get.textTheme.bodySmall,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                Imgs.ic_share,
                width: 24,
                height: 24,
              ))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
             width: 125,height: 170,
              child: DropShadowImage(
                  offset: Offset.zero,
                  scale: 1,
                  blurRadius: 5,
                  borderRadius: 3,
                  image:  BookCover(title: "123",
                    width: 120,height: 164,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '道德家',
              style: Get.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              '老子',
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 25,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 24, right: 24, bottom: 21),
                          child: Row(
                            children: [
                              mue('目录', '7.2', 'w'),
                              const SizedBox(
                                width: 16,
                              ),
                              mue('全文', '81', '章节'),
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          children: [
                            Text(
                              '简介：《道德真经》即《道德经》，又称《老子》、《老子五千文》。共81章，5000余言，分上下篇。老子著。 老子姓李名耳，字聃，一字伯阳，或曰谥伯阳，春秋时期人，生卒年不详，籍贯也多有争议。老子为道家学派创始人和主要代表人物，与庄子并称“老庄”。在道教中被尊为道祖，称“太上老君”。在道教中，《庄子》又称《南华真经》，《列子》又称《冲虚真经》，与《道德真经》合称三真经，被道教奉为主要经典。简介：《道德真经》即《道德经》，又称《老子》、《老子五千文》。共81章，5000余言，分上下篇。老子著。 老子姓李名耳，字聃，一字伯阳，或曰谥伯阳，春秋时期人，生卒年不详，籍贯也多有争议。老子为道家学派创始人和主要代表人物，与庄子并称“老庄”。在道教中被尊为道祖'
                              ' ，称“太上老君”。在道教中，《庄子》又称《南华真经》，《列子》又称《冲虚真经》，与《道德真经》合称三真经，被道教奉为主要经典。',
                              style: Get.textTheme.labelLarge!
                                  .copyWith(fontSize: 14, height: 1.5),
                            ),
                          ],
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 30, left: 18, right: 18, top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 44,
                                  child: OutlinedButton.icon(
                                      onPressed: () {
                                        Get.to(()=>Test());

                                      },
                                      icon: Image.asset(
                                        Imgs.ic_earphone,
                                        width: 20,
                                        height: 20,
                                      ),
                                      label: Text(
                                        '听书',
                                        style: Get.textTheme.bodySmall,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                    height: 44,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed(Routers.bookReaderPage);
                                        },
                                        child: Text('阅读全文')),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget mue(String title, String s1, String s2) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            color: Color(0xffF4F5F7), borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(
              title,
              style: Get.textTheme.bodySmall,
            ),
            const Spacer(),
            Text(
              s1,
              style: Get.textTheme.bodyMedium,
            ),
            Text(
              s2,
              style: Get.textTheme.bodySmall!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


}
