package gadget.util
{

	
	import gadget.service.LocaleService;
	
	import mx.formatters.NumberFormatter;
	import mx.resources.Locale;
	
	public class NumberLocaleUtils
	{
		
		public function NumberLocaleUtils()
		{
		}
		public static function format(value:Object,precison:int=2):String {
			if(value == null) return "";
			
			//var code:String = LocaleUtils.getLocaleCode();
			var numfomatter:NumberFormatter = new NumberFormatter();
//			numfomatter.fractionalDigits = precison;
			numfomatter.precision = precison;
//			numfomatter.decimalSeparatorTo = ".";
//			numfomatter.decimalSeparatorFrom = ".";
//			numfomatter.thousandsSeparatorTo = ",";
//			numfomatter.thousandsSeparatorFrom =",";
			var val:String = numfomatter.format(value);
			return val;
		}
		
	}
}