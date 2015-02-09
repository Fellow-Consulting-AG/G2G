package gadget.util
{
	import gadget.dao.Database;

	public class SalesStageUtils
	{
		private static var mapClosedWon:Object ={ENU:"Closed/Won",DEU:"Abgeschlossen/Gewonnen",ITA:"Chiuso/vinto",ESN:"Cerrada/Ganada"};
		private static var mapClosedLost:Object ={ENU:"Closed/Lost",DEU:"Abgeschlossen/Verloren",ITA:"Chiuso/perso",ESN:"Cerrada/Perdida"};
		private static var lngCode:String = Database.allUsersDao.ownerUser().LanguageCode;
		public function SalesStageUtils()
		{
		}
		public  static function getCloseWonValue():String{
			var val:String = mapClosedWon[lngCode];
			if(StringUtils.isEmpty(val)){
				val = mapClosedWon["ENU"];
			}
			return val;
		}
		public  static function getCloseLostValue():String{
			var val:String = mapClosedLost[lngCode];
			if(StringUtils.isEmpty(val)){
				val = mapClosedLost["ENU"];
			}
			return val;
		}
	}
}