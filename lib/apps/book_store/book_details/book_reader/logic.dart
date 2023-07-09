import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:huaxia/apps/book_store/model/Catalogue.dart';
import 'package:huaxia/apps/book_store/model/Chapters.dart';
import 'package:huaxia/config/config.dart';
import 'package:huaxia/widgets/custom_selectable_text/custom_selectable_text.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../model/BookList.dart';

class BookReaderLogic extends GetxController {
  var showFistPop = true.obs;
  late List<CustomSelectableTextItem> customSelectableTextItems;

// final PageController controller = PageController();
  var menuBarShow = false.obs;
  var menuBottomShow = false.obs;
  var currentIndex = 0.obs;
  var m1 = false.obs;
  var m2 = false.obs;
  var m3 = false.obs;
  var m4 = false.obs;

  var translateText = 0.obs;
  late String data;
  late Future<double> brightness;
  List<List<String>> len = [];
  late Future<List<List<String>>> f;

  late BookList book;

  RxList<Catalogue> catalogues = RxList([]);
  RxMap<Catalogue, Future<ApiResult<Chapters>>> cc = RxMap();

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener
      .create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener
      .create();

  @override
  void onInit() {
    book = Get.arguments as BookList;
    super.onInit();
    initBook();
    brightness = ScreenBrightness().system;
    data = '''
  \n　　子曰：“为政以德，譬如北辰，居其所而众星共之。”\n
　子曰：“《诗》三百，一言以蔽之，曰：‘思无邪’。”\n
  <p>　　子曰：<u>“道之以政，齐之<u>以刑</u>，民免而无耻。道</u>之以德，齐之以礼，有耻且格。”</p>\n
  <p>　　子曰：“吾十有五而志于学，三十而立，四十而不惑，五十而知天命，六十而耳顺，七十而从心所欲，不逾矩。”</p>\n<p>　　孟懿子问孝，子曰：“无违。”樊迟御，子告之曰：“孟孙问孝于我，我对曰‘无违’。”樊迟曰：“何谓也？”子曰：“生，事之以礼；死，葬之以礼，祭之以礼。”</p>\n<p>　　孟武伯问孝。子曰：“父母唯其疾之忧。”</p>\n<p>　　子游问孝。子曰：“今之孝者，是谓能养。至于犬马，皆能有养；不敬，何以别乎？”</p>\n<p>　　子夏问孝。子曰：“色难。有事，弟子服其劳；有酒食，先生馔，曾是以为孝乎？”</p>\n<p>　　子曰：“吾与回言终日，不违，如愚。退而省其私，亦足以发，回也不愚。”</p>\n<p>　　子曰：“视其所以，观其所由，察其所安，人焉廋哉？人焉廋哉？”</p>\n<p>　　子曰：“温故而知新，可以为师矣。”</p>\n<p>　　子曰：“君子不器。”</p>\n<p>　　子贡问君子。子曰：“先行其言而后从之。”</p>\n<p>　　子曰：“君子周而不比，小人比而不周。”</p>\n<p>　　子曰：“学而不思则罔，思而不学则殆。”</p>\n<p>　　子曰：“攻乎异端，斯害也已！”</p>\n<p>　　子曰：“由，诲女知之乎！知之为知之，不知为不知，是知也。”</p>\n<p>　　子张学干禄。子曰：“多闻阙疑，慎言其余，则寡尤；多见阙殆，慎行其余，则寡悔。言寡尤，行寡悔，禄在其中矣。”</p>\n<p>　　哀公问曰：“何为则民服？”孔子对曰：“举直错诸枉，则民服；举枉错诸直，则民不服。”</p>\n<p>　　季康子问：“使民敬、忠以劝，如之何？”子曰：“临之以庄，则敬；孝慈，则忠；举善而教不能，则劝。”</p>\n<p>　　或谓孔子曰：“子奚不为政？”子曰：“《书》云：‘孝乎惟孝，友于兄弟。’施于有政，是亦为政，奚其为为政？”</p>\n<p>　　子曰：“人而无信，不知其可也。大车无輗，小车无軏，其何以行之哉？”</p>\n<p>　　子张问：“十世可知也？”子曰：“殷因于夏礼，所损益，可知也；周因于殷礼，所损益，可知也。其或继周者，虽百世，可知也。”</p>\n<p>　　子曰：“非其鬼而祭之，谄也；见义不为，无勇也。”</p>\n",
		"yiwen": "\n<p>　　孔子说：“用道德来统治国家的人，就会像北极星一样处在一定的位置，所有的星辰都会环绕在它的周围。”</p>\n<p>　　孔子说：“《诗经》三百篇，可以用一句话来概括它，就是‘思想纯正’。”</p>\n<p>　　孔子说：“用强权手段、法制禁令来管理百姓，使用刑法来约束他们，老百姓只能免于犯罪受惩罚，却没有了廉耻之心；用道德引导百姓，用礼制去统一百姓的言行，不但懂得廉洁是非，而且从心里归服。”</p>\n<p>　　孔子说：“我十五岁立志于学习；三十岁就有了自己的德行和做人的原则；四十岁遇到事情不再感到困惑；五十岁就知道哪些是不能为人力支配的事情而乐知天命；六十岁能正确对待各种言论，不觉得不能接受；七十岁能随心所欲而不越出规矩。”</p>\n<p>　　孟懿子问什么是孝，孔子说：“孝就是不要违背礼。”不久，樊迟替孔子驾车，孔子告诉他说：“孟孙问我什么是孝道，我回答他说不要违背礼。”樊迟说：“这是什么意思呢？”孔子说：“父母活着的时候，要依照规定的礼节侍奉他们；父母去世后，依规定的礼节安葬他们，祭祀他们。”</p>\n<p>　　孟武伯问什么是孝。孔子说：“除生病不能避免外，不要让父母担忧子女的任何事情。”</p>\n<p>　　子游问什么是孝。孔子说：“当今许多人认为的孝呀，就是能够赡养父母便足够了。其实狗和马，也都有人饲养。如果对自己的父母不恭敬孝顺，那么赡养父母与饲养犬马又有什么区别呢？”</p>\n<p>　　子夏问什么是孝。孔子说：“侍奉父母时，最不容易的就是对父母和颜悦色。有了事情，儿女替父母去做，有了可口的饭菜，让父母吃，难道能认为这样就可以算是孝了吗？”</p>\n<p>　　孔子说：“我给颜回授课，一整天下来他都不提任何反对意见和疑问，像个愚钝的人。等他回去后，我观察他私下里同别人讨论时，却能发挥我所讲的，可见颜回他并不愚笨呀！”</p>\n<p>　　孔子说：“看一个人的所作所为，应看他言行的动机，观察他所走的道路，了解他心安于什么事情。这样，这个人怎样能隐藏得了呢？这个人怎样能隐藏得了呢？”</p>\n<p>　　孔子说：“温习学过的知识，可以从中获得新的理解与体会，那么就可以凭借这一点去做老师了。”</p>\n<p>　　孔子说：“君子不像器具那样，只有一种用途。”</p>\n<p>　　子贡问怎样做一个君子。孔子说：“应该先行动实践自己想要说的话，做到后再把它说出来。”</p>\n<p>　　孔子说：“德行高尚的人以正道广泛交友但不互相勾结，品格卑下的人互相勾结却不顾道义。”</p>\n<p>　　孔子说：“只学习却不思考，就会感到迷茫而无所适从，只是思考而不学习，就会疑惑而无所得。”</p>\n<p>　　孔子说：“研攻异端杂学，不过带来危害罢了。”</p>\n<p>　　孔子说：“仲由啊，让为师教导你对待知与不知的态度吧！知道就是知道，不知道就是不知道，这才是聪明的。”</p>\n<p>　　子张要学谋取官职的办法。孔子说：“要多听，不明白的地方先放在一旁不说，对于真正懂得的，也要谨慎地说出来，这样就能少犯错误；要多看，有疑惑的先放在一旁不做，对于真正懂的，也要谨慎地去做，这样就能减少事后懊悔。说话很少犯错，做事很少后悔，自然就有官职俸禄了。”</p>\n<p>　　鲁哀公问：“用什么方法才能让老百姓服从呢？”孔子回答说：“提拔那些正直的人，让他们居于不正直的人之上，老百姓就会服从了；把不正直的人提拔上来，让他们居于正直的人之上，老百姓就不会服从统治了。”</p>\n<p>　　季康子问道：“要让老百姓恭敬、尽忠并互相勉励，应该怎么做呢？”孔子说：“如果你用庄重的态度对待他们，他们就会恭敬；如果你能孝顺父母、爱护幼小，他们就会忠诚；如果你能任用贤能之士，教育能力低下的人，他们就会互相勉励。”</p>\n<p>　　有人对孔子说：“你为什么不去从政呢？”孔子回答说：“《尚书》上说，‘孝就是孝敬父母，友爱兄弟。’把这孝悌的道理施于政事，也就是参与政事了，你以为要怎样才能算是参与政事呢？”</p>\n<p>　　孔子说：“一个人如果不讲信用，不知道他还能做什么。就好像牛车没有大车辕和车辕前横木相接的关键，马车没有辕前横木两端的木销，它还怎么行驶呢？”</p>\n<p>　　子张问孔子：“今后十世的礼仪制度可以预知吗？”孔子回答说：“商朝承袭了夏朝的礼仪制度，其中减少和所增加的内容是可以知道的；周朝又承袭了商朝的礼仪制度，其中减少和所增加的内容也是可以知道的。以后如果有继承周朝的朝代，就是一百世以后的情况，也是可以预先知道的。”</p>\n<p>　　孔子说：“不是自己的先祖而去祭祀，就是谄媚。见到应该挺身而出的事情，却袖手旁观，就是怯懦。”</p>\n",
		"duanluo": "\n<p>　　子曰：“为政以德，譬如北辰，居其所而众星共之。”<br/><span style=\"color:#af9100;\">　　孔子说：“用道德来统治国家的人，就会像北极星一样处在一定的位置，所有的星辰都会环绕在它的周围。”</span></p><p>　　子曰：“《诗》三百，一言以蔽之，曰：‘思无邪’。”<br/><span style=\"color:#af9100;\">　　孔子说：“《诗经》三百篇，可以用一句话来概括它，就是‘思想纯正’。”</span></p><p>　　子曰：“道之以政，齐之以刑，民免而无耻。道之以德，齐之以礼，有耻且格。”<br/><span style=\"color:#af9100;\">　　孔子说：“用强权手段、法制禁令来管理百姓，使用刑法来约束他们，老百姓只能免于犯罪受惩罚，却没有了廉耻之心；用道德引导百姓，用礼制去统一百姓的言行，不但懂得廉洁是非，而且从心里归服。”</span></p><p>　　子曰：“吾十有五而志于学，三十而立，四十而不惑，五十而知天命，六十而耳顺，七十而从心所欲，不逾矩。”<br/><span style=\"color:#af9100;\">　　孔子说：“我十五岁立志于学习；三十岁就有了自己的德行和做人的原则；四十岁遇到事情不再感到困惑；五十岁就知道哪些是不能为人力支配的事情而乐知天命；六十岁能正确对待各种言论，不觉得不能接受；七十岁能随心所欲而不越出规矩。”</span></p><p>　　孟懿子问孝，子曰：“无违。”樊迟御，子告之曰：“孟孙问孝于我，我对曰‘无违’。”樊迟曰：“何谓也？”子曰：“生，事之以礼；死，葬之以礼，祭之以礼。”<br/><span style=\"color:#af9100;\">　　孟懿子问什么是孝，孔子说：“孝就是不要违背礼。”不久，樊迟替孔子驾车，孔子告诉他说：“孟孙问我什么是孝道，我回答他说不要违背礼。”樊迟说：“这是什么意思呢？”孔子说：“父母活着的时候，要依照规定的礼节侍奉他们；父母去世后，依规定的礼节安葬他们，祭祀他们。”</span></p><p>　　孟武伯问孝。子曰：“父母唯其疾之忧。”<br/><span style=\"color:#af9100;\">　　孟武伯问什么是孝。孔子说：“除生病不能避免外，不要让父母担忧子女的任何事情。”</span></p><p>　　子游问孝。子曰：“今之孝者，是谓能养。至于犬马，皆能有养；不敬，何以别乎？”<br/><span style=\"color:#af9100;\">　　子游问什么是孝。孔子说：“当今许多人认为的孝呀，就是能够赡养父母便足够了。其实狗和马，也都有人饲养。如果对自己的父母不恭敬孝顺，那么赡养父母与饲养犬马又有什么区别呢？”</span></p><p>　　子夏问孝。子曰：“色难。有事，弟子服其劳；有酒食，先生馔，曾是以为孝乎？”<br/><span style=\"color:#af9100;\">　　子夏问什么是孝。孔子说：“侍奉父母时，最不容易的就是对父母和颜悦色。有了事情，儿女替父母去做，有了可口的饭菜，让父母吃，难道能认为这样就可以算是孝了吗？”</span></p><p>　　子曰：“吾与回言终日，不违，如愚。退而省其私，亦足以发，回也不愚。”<br/><span style=\"color:#af9100;\">　　孔子说：“我给颜回授课，一整天下来他都不提任何反对意见和疑问，像个愚钝的人。等他回去后，我观察他私下里同别人讨论时，却能发挥我所讲的，可见颜回他并不愚笨呀！”</span></p><p>　　子曰：“视其所以，观其所由，察其所安，人焉廋哉？人焉廋哉？”<br/><span style=\"color:#af9100;\">　　孔子说：“看一个人的所作所为，应看他言行的动机，观察他所走的道路，了解他心安于什么事情。这样，这个人怎样能隐藏得了呢？这个人怎样能隐藏得了呢？”</span></p><p>　　子曰：“温故而知新，可以为师矣。”<br/><span style=\"color:#af9100;\">　　孔子说：“温习学过的知识，可以从中获得新的理解与体会，那么就可以凭借这一点去做老师了。”</span></p><p>　　子曰：“君子不器。”<br/><span style=\"color:#af9100;\">　　孔子说：“君子不像器具那样，只有一种用途。”</span></p><p>　　子贡问君子。子曰：“先行其言而后从之。”<br/><span style=\"color:#af9100;\">　　子贡问怎样做一个君子。孔子说：“应该先行动实践自己想要说的话，做到后再把它说出来。”</span></p><p>　　子曰：“君子周而不比，小人比而不周。”<br/><span style=\"color:#af9100;\">　　孔子说：“德行高尚的人以正道广泛交友但不互相勾结，品格卑下的人互相勾结却不顾道义。”</span></p><p>　　子曰：“学而不思则罔，思而不学则殆。”<br/><span style=\"color:#af9100;\">　　孔子说：“只学习却不思考，就会感到迷茫而无所适从，只是思考而不学习，就会疑惑而无所得。”</span></p><p>　　子曰：“攻乎异端，斯害也已！”<br/><span style=\"color:#af9100;\">　　孔子说：“研攻异端杂学，不过带来危害罢了。”</span></p><p>　　子曰：“由，诲女知之乎！知之为知之，不知为不知，是知也。”<br/><span style=\"color:#af9100;\">　　孔子说：“仲由啊，让为师教导你对待知与不知的态度吧！知道就是知道，不知道就是不知道，这才是聪明的。”</span></p><p>　　子张学干禄。子曰：“多闻阙疑，慎言其余，则寡尤；多见阙殆，慎行其余，则寡悔。言寡尤，行寡悔，禄在其中矣。”<br/><span style=\"color:#af9100;\">　　子张要学谋取官职的办法。孔子说：“要多听，不明白的地方先放在一旁不说，对于真正懂得的，也要谨慎地说出来，这样就能少犯错误；要多看，有疑惑的先放在一旁不做，对于真正懂的，也要谨慎地去做，这样就能减少事后懊悔。说话很少犯错，做事很少后悔，自然就有官职俸禄了。”</span></p><p>　　哀公问曰：“何为则民服？”孔子对曰：“举直错诸枉，则民服；举枉错诸直，则民不服。”<br/><span style=\"color:#af9100;\">　　鲁哀公问：“用什么方法才能让老百姓服从呢？”孔子回答说：“提拔那些正直的人，让他们居于不正直的人之上，老百姓就会服从了；把不正直的人提拔上来，让他们居于正直的人之上，老百姓就不会服从统治了。”</span></p><p>　　季康子问：“使民敬、忠以劝，如之何？”子曰：“临之以庄，则敬；孝慈，则忠；举善而教不能，则劝。”<br/><span style=\"color:#af9100;\">　　季康子问道：“要让老百姓恭敬、尽忠并互相勉励，应该怎么做呢？”孔子说：“如果你用庄重的态度对待他们，他们就会恭敬；如果你能孝顺父母、爱护幼小，他们就会忠诚；如果你能任用贤能之士，教育能力低下的人，他们就会互相勉励。”</span></p><p>　　或谓孔子曰：“子奚不为政？”子曰：“《书》云：‘孝乎惟孝，友于兄弟。’施于有政，是亦为政，奚其为为政？”<br/><span style=\"color:#af9100;\">　　有人对孔子说：“你为什么不去从政呢？”孔子回答说：“《尚书》上说，‘孝就是孝敬父母，友爱兄弟。’把这孝悌的道理施于政事，也就是参与政事了，你以为要怎样才能算是参与政事呢？”</span></p><p>　　子曰：“人而无信，不知其可也。大车无輗，小车无軏，其何以行之哉？”<br/><span style=\"color:#af9100;\">　　孔子说：“一个人如果不讲信用，不知道他还能做什么。就好像牛车没有大车辕和车辕前横木相接的关键，马车没有辕前横木两端的木销，它还怎么行驶呢？”</span></p><p>　　子张问：“十世可知也？”子曰：“殷因于夏礼，所损益，可知也；周因于殷礼，所损益，可知也。其或继周者，虽百世，可知也。”<br/><span style=\"color:#af9100;\">　　子张问孔子：“今后十世的礼仪制度可以预知吗？”孔子回答说：“商朝承袭了夏朝的礼仪制度，其中减少和所增加的内容是可以知道的；周朝又承袭了商朝的礼仪制度，其中减少和所增加的内容也是可以知道的。以后如果有继承周朝的朝代，就是一百世以后的情况，也是可以预先知道的。”</span></p><p>　　子曰：“非其鬼而祭之，谄也；见义不为，无勇也。”<br/><span style=\"color:#af9100;\">　　孔子说：“不是自己的先祖而去祭祀，就是谄媚。见到应该挺身而出的事情，却袖手旁观，就是怯懦。”</span></p>\n
  ''';

    docVN = ValueNotifier(data);
    itemPositionsListener.itemPositions.addListener(() {

    });
    init();
  }

  void initBook() {
    Api.book_Catalogue(book.bookId!).then((value) {
      if (value.success) {
        catalogues.value = value.data ?? [];
        if (catalogues.first.bookCatalogueId != null) {
          cc[catalogues.first] = Api.book_Chapters(bookId: book.bookId!,
              chaptersId: catalogues.first.bookCatalogueId!);
        }
      } else {
        AppToast.toast(value.message);
        Get.back();
      }
    });
  }

  toCuttex(int index) {
    getBook_Chapters(index);
    itemScrollController.jumpTo(index: index);
  }


  Future<ApiResult<Chapters>>  getBook_Chapters(int index) {
    final cl = catalogues[index];
    if (cc.containsKey(cl) && cc[cl]!=null) {
      return cc[cl]!;
    } else {
      final f = Api.book_Chapters(
          bookId: book.bookId!, chaptersId: cl.bookCatalogueId!);
      cc[cl] = f;
      return f;
    }
  }

  late ValueNotifier<String> docVN;

  init() {
    customSelectableTextItems = [
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_copy,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '复制',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.copy,
          onPressed: (text, d) {
            AppToast.toast('复制成功');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_share,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '分享',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_line,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '划线',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, textSelection) {
            String changed = '<u>$text</u>';

            data = data.replaceRange(
                textSelection.start, textSelection.end, changed);
            docVN.value = data;
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_idea,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '想法',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
      CustomSelectableTextItem.icon(
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Imgs.ic_text_idea,
                width: 18,
                height: 18,
                color: Colors.white,
              ),
              const Text(
                '查询',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          controlType: SelectionControlType.other,
          onPressed: (text, d) {
            AppToast.toast('正在开发中...');
          }),
    ];
  }

  openMenuList(int index) {
    currentIndex.value = index;

    switch (index) {
      case 0:
        m1.value = !m1.value;
        menuBarShow.value = !m1.value;
        m2.value = false;
        m3.value = false;
        m4.value = false;
        break;
      case 1:
        m2.value = !m2.value;
        menuBarShow.value = !m2.value;
        m1.value = false;
        m3.value = false;
        m4.value = false;
        break;
      case 2:
        m3.value = !m3.value;
        menuBarShow.value = !m3.value;
        m1.value = false;
        m2.value = false;
        m4.value = false;
        break;
      case 3:
        m4.value = !m4.value;
        menuBarShow.value = !m4.value;
        m2.value = false;
        m3.value = false;
        m1.value = false;
        break;
    }
  }

  void onTapMenu() {
    menuBottomShow.value = !menuBottomShow.value;
    menuBarShow.value = menuBottomShow.value;
    m1.value = false;
    m2.value = false;
    m3.value = false;
    m4.value = false;
  }


}
