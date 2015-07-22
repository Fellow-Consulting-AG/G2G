package gadget.util
{
	import flash.globalization.NumberFormatter;
	import flash.globalization.NumberParseResult;
	
	import gadget.service.LocaleService;
	
	import mx.resources.Locale;
	
	public class NumberLocaleUtils
	{
		
		public function NumberLocaleUtils()
		{
		}
		public static function format(value:Object,precison:int=2):String {
			if(value == null) value=0;
			var languageInfo:Object = LocaleService.getLanguageInfo();
			var code:String = LocaleUtils.getLocaleCode(languageInfo.LanguageCode);
			var numfomatter:NumberFormatter = new NumberFormatter(code);
			numfomatter.fractionalDigits = precison;
//			numfomatter.precision = 0;
//			numfomatter.decimalSeparatorTo = ".";
//			numfomatter.decimalSeparatorFrom = ".";
//			numfomatter.thousandsSeparatorTo = ",";
//			numfomatter.thousandsSeparatorFrom =",";
			var val:String = numfomatter.formatNumber(parse(value));
			return val;
		}
		public static function parse(value:Object):Number {
			var languageInfo:Object = LocaleService.getLanguageInfo();
			var code:String = LocaleUtils.getLocaleCode(languageInfo.LanguageCode);
			var numfomatter:NumberFormatter = new NumberFormatter(code);
			var val:NumberParseResult = numfomatter.parse(value+"");
			return val.value;
		}
	}
}