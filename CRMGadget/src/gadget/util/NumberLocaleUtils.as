package gadget.util
{

	
	import com.adobe.utils.StringUtil;
	
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
			if(value == null) return "";
			
			//var code:String = LocaleUtils.getLocaleCode();
			var numfomatter:NumberFormatter = new NumberFormatter(LocaleUtils.getLocaleCode());
			numfomatter.fractionalDigits = precison;
//			numfomatter.precision = precison;
//			numfomatter.decimalSeparatorTo = ".";
//			numfomatter.decimalSeparatorFrom = ".";
//			numfomatter.thousandsSeparatorTo = ",";
//			numfomatter.thousandsSeparatorFrom =",";
			var val:String = numfomatter.formatNumber(parseFloat(parse(value.toString())));
			return val;
		}
		
		public static function parse(value:String,decimal:int=4):String {
			
			var numfomatter:NumberFormatter = new NumberFormatter(LocaleUtils.getLocaleCode());
			var val:NumberParseResult = numfomatter.parse(StringUtil.trim(value));
			if(val!=null && !isNaN(val.value)){
				if(decimal!=-1){
				
					return val.value.toFixed(decimal);
				}else{
					val.value.toString();
				}
				
			}
			return null;
		}
		
	}
}