package gadget.util
{
	import gadget.service.LocaleService;

	public class LocaleUtils
	{
		private static const LOCALES:Object = {
			'0D-CCOZE':'ch_CH',
			'0-118':'ch_CH',
			'0D-CCOZD':'ch_CH',
			'0-205':'ch_CH',
			'0-BAA65':'nl_NL',
			'0-109':'nl_NL',
			'0-BAA5D':'en_US',
			'0-BAA5G':'en_US',
			'0-208':'en_US',
			'0-BAA5I':'en_US',
			'0-206':'en_US',
			'0-204':'en_US',
			'0-203':'en_US',
			'0-111':'en_US',
			'0-101':'en_US',
			'0-112':'fr_FR',
			'0-BAA5K':'fr_FR',
			'0-103':'fr_FR',
			'0-BAA5P':'fr_FR',
			'0-BAA5R':'fr_FR',
			'0-BAA5T':'de_DE',
			'0-106':'de_DE',
			'0-BAA5Z':'de_DE',
			'0-BAA5V':'de_DE',
			'0-104':'it_IT',
			'0-102':'jp_JP',
			'0-212':'pl_PL',
			'0-LCBRA':'pt_PT',
			'0-114':'pt_PT',
			'0-211':'ru_RU',
			'0P-BAA66':'es_ES',
			'0-BAA61':'es_ES',
			'0-116':'es_ES'
			
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
			
			if(localeCode == null || localeCode == ""){
				return 'en_US';
			}else{
				return LOCALES[localeCode]==null?'en_US':LOCALES[localeCode];
			}
			
		}
		
	}
}