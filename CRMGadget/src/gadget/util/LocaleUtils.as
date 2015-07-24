package gadget.util
{
	import gadget.service.LocaleService;

	public class LocaleUtils
	{
		private static const LOCALES:Object = {
			'0D_CCOZE':'ch_CH',
			'0_118':'ch_CH',
			'0D_CCOZD':'ch_CH',
			'0_205':'ch_CH',
			'0_BAA65':'nl_NL',
			'0_109':'nl_NL',
			'0_BAA5D':'en_US',
			'0_BAA5G':'en_US',
			'0_208':'en_US',
			'0_BAA5I':'en_US',
			'0_206':'en_US',
			'0_204':'en_US',
			'0_203':'en_US',
			'0_111':'en_US',
			'0_101':'en_US',
			'0_112':'fr_FR',
			'0_BAA5K':'fr_FR',
			'0_103':'fr_FR',
			'0_BAA5P':'fr_FR',
			'0_BAA5R':'fr_FR',
			'0_BAA5T':'de_DE',
			'0_106':'de_DE',
			'0_BAA5Z':'de_DE',
			'0_BAA5V':'de_DE',
			'0_104':'it_IT',
			'0_102':'jp_JP',
			'0_212':'pl_PL',
			'0_LCBRA':'pt_PT',
			'0_114':'pt_PT',
			'0_211':'ru_RU',
			'0P_BAA66':'es_ES',
			'0_BAA61':'es_ES',
			'0_116':'es_ES'
			
		};
		
		public function LocaleUtils()
		{
		}
		public static function getLocaleCodeByLanguage(lngCode):String{
			if(lngCode == null || lngCode == ""){
				return 'en_US';
			}else{
				return LOCALES[lngCode]==null?'en_US':LOCALES[lngCode];
			}
			
		}
		public static function getLocaleCode():String{
			//0_1OBMR = en_US
			var languageInfo:Object = LocaleService.getLanguageInfo();
			var localeCode:String = languageInfo.LocaleCode;
			return 'de_DE';
//			if(localeCode == null || localeCode == ""){
//				return 'en_US';
//			}else{
//				return LOCALES[localeCode]==null?'en_US':LOCALES[localeCode];
//			}
			
		}
		
	}
}