
class Imgs{
  Imgs._();
  static final String ic_bar_jz =getPath('ic_bar_jz');
  static final String ic_bar_jz_a =getPath('ic_bar_jz_a');
  static final String ic_bar_me =getPath('ic_bar_me');
  static final String ic_bar_me_a =getPath('ic_bar_me_a');
  static final String ic_bar_sc =getPath('ic_bar_sc');
  static final String ic_bar_sc_a =getPath('ic_bar_sc_a');
  static final String bg_banner_1 =getPath('bg_banner_1');
  static final String bg_banner_2 =getPath('bg_banner_2');
  static final String bg_banner_3 =getPath('bg_banner_3');
  static final String bg_banner_4 =getPath('bg_banner_4');
  static final String ic_search =getPath('ic_search');
  static final String ic_check =getPath('ic_check');
  static final String ic_delect =getPath('ic_delect');
  static final String ic_share =getPath('ic_share');
  static final String ic_add_book =getPath('ic_add_book');
  static final String ic_earphone =getPath('ic_earphone');
  static final String ic_sc =getPath('ic_sc');
  static final String ic_text_copy =getPath('ic_text_copy');
  static final String ic_text_idea =getPath('ic_text_idea');
  static final String ic_text_line =getPath('ic_text_line');
  static final String ic_gesture =getPath('ic_gesture');
  static final String ic_next =getPath('ic_next');
  static final String ic_pre =getPath('ic_pre');

  static final String ic_join =getPath('ic_join');
  static final String ic_me_bg =getPath('ic_me_bg');
  static final String ic_me_book =getPath('ic_me_book');
  static final String ic_me_browse =getPath('ic_me_browse');
  static final String ic_me_feedback =getPath('ic_me_feedback');
  static final String ic_me_group =getPath('ic_me_group');
  static final String ic_me_notes =getPath('ic_me_notes');
  static final String ic_me_sentence =getPath('ic_me_sentence');
  static final String ic_me_vip_bg =getPath('ic_me_vip_bg');
  static final String ic_vip =getPath('ic_vip');
  static final String ic_widget =getPath('ic_widget');
  static final String ic_wach =getPath('ic_wach');
  static final String ic_like =getPath('ic_like');
  static final String ic_like_no =getPath('ic_like_no');






  static String getPath(String path,{String? s}){
    if(s==null ||s.isEmpty){
      s = ".webp";
    }

    return "assets/images/$path$s";
  }
}