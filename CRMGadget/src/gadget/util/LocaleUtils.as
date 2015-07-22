package gadget.util
{
	public class LocaleUtils
	{
		private static const LOCALS:Object = {
			DEU:'de-DE',
			ENU:'en-US',
			USA:'en-US',
			ESN:'es-ES',
			FRA:'fr-FR',
			PTG:'pt-PT',
			NLD:'nl-NL',
			JPN:'jp-JP',
			CHS:'ch-CH',
			SVE:'sv-SV',
			PLK:'pl-PL',
			RUS:'ru-RU',
			ITA:'it-IT'
			
		};
		public function LocaleUtils()
		{
		}
		public static function getLocaleCode(userCode:String="ENU"):String{
			return LOCALS[userCode];
		}
	}
}