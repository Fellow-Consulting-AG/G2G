package gadget.util
{
	public class LocaleUtils
	{
		private static const LOCALES:Object = {
			'0D-CCOZE':'ch-CH',
			'0-118':'ch-CH',
			'0D-CCOZD':'ch-CH',
			'0-205':'ch-CH',
			'0-BAA65':'nl-NL',
			'0-109':'nl-NL',
			'0-BAA5D':'en-US',
			'0-BAA5G':'en-US',
			'0-208':'en-US',
			'0-BAA5I':'en-US',
			'0-206':'en-US',
			'0-204':'en-US',
			'0-203':'en-US',
			'0-111':'en-US',
			'0-101':'en-US',
			'0-112':'fr-FR',
			'0-BAA5K':'fr-FR',
			'0-103':'fr-FR',
			'0-BAA5P':'fr-FR',
			'0-BAA5R':'fr-FR',
			'0-BAA5T':'de-DE',
			'0-106':'de-DE',
			'0-BAA5Z':'de-DE',
			'0-BAA5V':'de-DE',
			'0-104':'it-IT',
			'0-102':'jp-JP',
			'0-212':'pl-PL',
			'0-LCBRA':'pt-PT',
			'0-114':'pt-PT',
			'0-211':'ru-RU',
			'0P-BAA66':'es-ES',
			'0-BAA61':'es-ES',
			'0-116':'es-ES'
			
		};
		
		public function LocaleUtils()
		{
		}
		public static function getLocaleCode(localeCode:String):String{
			//0-1OBMR = en-US
			if(localeCode == null || localeCode == ""){
				return 'en-US';
			}else{
				return LOCALES[localeCode]==null?'en-US':LOCALES[localeCode];
			}
			
		}
	}
}